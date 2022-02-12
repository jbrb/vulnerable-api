defmodule VulnerableApiWeb.GraphQL.Resolvers.AccountResolver do
  alias VulnerableApi.Accounts

  def get_user(%{user_id: user_id}, _) do
    {:ok, Accounts.get_user(user_id)}
  end

  def create_user(args, _) do
    Accounts.create_user(args)
  end
end
