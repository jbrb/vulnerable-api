defmodule VulnerableApiWeb.GraphQL.Resolvers.AccountResolver do
  alias VulnerableApi.Accounts
  alias VulnerableApi.Guardian
  alias VulnerableApi.Utils.ErrorHandler

  def login(args, _) do
    case Accounts.get_user_by_email(args.email) do
      nil ->
        {:error, %{code: 404, message: "Not found."}}

      user ->
        if Accounts.authenticate(user, args.password) do
          # here we put ttl options to adjust token expiry
          {:ok, token, _claims} = Guardian.encode_and_sign(user, %{}, ttl: {1, :hour})
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

  def search_user(%{keyword: keyword}, _) do
    {:ok, Accounts.search_user(keyword)}
  end

  def create_user(args, _) do
    case Accounts.create_user(args) do
      {:ok, user} ->
        {:ok, user}

      {:error, changeset} ->
        {:error, %{message: ErrorHandler.format_errors(changeset)}}
    end
  end

  def update_user(%{user_id: user_id} = args, _) do
    case Accounts.get_user(user_id) do
      %{id: _} = user ->
        Accounts.update_user(user, args)

      _ ->
        {:error, %{message: "User Not found."}}
    end
  end

  def update_user(args, %{context: %{current_user: user}}) do
    Accounts.update_user(user, args)
  end

  def delete_user(%{user_id: user_id}, _) do
    case Accounts.get_user(user_id) do
      %{id: _} = user ->
        {:ok, Accounts.delete_user(user)}

      _ ->
        {:error, %{message: "User Not found."}}
    end
  end

  def add_credits(args, %{context: %{current_user: user}}) do
    case Accounts.get_user(user.id) do
      nil ->
        {:error, %{message: "Not found.", code: 404}}

      user ->
        Accounts.add_credit(user, args.credits)
    end
  end

  def send_credits(args, %{context: %{current_user: user}}) do
    %{amount: sender_credits} = Accounts.get_user_total_credits(user)

    if sender_credits >= args.credits do
      case Accounts.get_user_by_email(args.email) do
        nil ->
          {:error, %{message: "Not found.", code: 404}}

        receiver ->
          Accounts.send_credits(user, receiver, args.credits)
      end
    else
      {:error, %{message: "Not enough credits.", code: 400}}
    end
  end

  def list_credits_history(_args, %{context: %{current_user: user}}) do
    {:ok, Accounts.list_user_credits_history(user)}
  end

  def get_user_credits(_args, %{context: %{current_user: user}}) do
    credits =
      case Accounts.get_user_total_credits(user) do
        %{amount: nil} -> %{amount: 0}
        credits -> credits
      end

    {:ok, credits}
  end
end
