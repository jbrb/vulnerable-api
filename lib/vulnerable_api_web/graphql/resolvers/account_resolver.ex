defmodule VulnerableApiWeb.GraphQL.Resolvers.AccountResolver do
  alias VulnerableApi.Accounts

  def login(args, _) do
    args
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
end
