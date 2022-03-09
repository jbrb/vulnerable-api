defmodule VulnerableApiWeb.GraphQL.Resolvers.AccountResolver do
  alias VulnerableApi.Accounts
  alias VulnerableApi.Guardian

  def login(args, _) do
    case Accounts.get_user_by_email(args.email) do
      nil ->
        {:error, %{code: 404, message: "Not found."}}

      user ->
        if Accounts.authenticate(user, args.password) do
          {:ok, token, _claims} = Guardian.encode_and_sign(user, %{})
          {:ok, %{token: token, user_id: user.id}}
        else
          {:error, %{code: 400, message: "Invalid credentials."}}
        end
    end
  end

  def list_users(_, _) do
    {:ok, Accounts.list_users()}
  end

  def get_user(%{user_id: user_id}, _) do
    {:ok, Accounts.get_user(user_id)}
  end

  def create_user(args, _) do
    Accounts.create_user(args)
  end

  def update_user(%{user_id: user_id} = args, _) do
    case Accounts.get_user(user_id) do
      %{id: _} = user ->
        Accounts.update_user(user, args)

      _ ->
        {:error, %{message: "User Not found."}}
    end
  end

  def delete_user(%{user_id: user_id}, _) do
    case Accounts.get_user(user_id) do
      %{id: _} = user ->
        {:ok, Accounts.delete_user(user)}

      _ ->
        {:error, %{message: "User Not found."}}
    end
  end

  def add_credits(args, _) do
    case Accounts.get_user(args.user_id) do
      nil ->
        {:error, %{message: "Not found.", code: 404}}

      user ->
        Accounts.add_credit(user, args.credits)
    end
  end

  def send_credits(args, %{context: %{user: user}}) do
    %{total: sender_credits} = Accounts.get_user_total_credits(user)

    if sender_credits >= args.credits do
      case Accounts.get_user(args.user_id) do
        nil ->
          {:error, %{message: "Not found.", code: 404}}

        receiver ->
          Accounts.add_credit(user, -args.credits)
          Accounts.add_credit(receiver, args.credits)
      end
    else
      {:error, %{message: "Not enough credits.", code: 400}}
    end
  end
end
