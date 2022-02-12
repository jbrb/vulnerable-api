defmodule VulnerableApi.Accounts do
  alias VulnerableApi.Accounts.User
  alias VulnerableApi.Repo

  def create_user(attrs) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def get_user(id), do: Repo.get(User, id)

  def update_user(user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def delete_user(user), do: Repo.delete(user)
end
