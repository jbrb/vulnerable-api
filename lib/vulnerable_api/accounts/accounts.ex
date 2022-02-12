defmodule VulnerableApi.Accounts do
  import Ecto.Query, warn: false

  alias VulnerableApi.Accounts.{Credit, User}
  alias VulnerableApi.Repo

  def list_users do
    Repo.all(User)
  end

  def create_user(attrs) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def get_user(id), do: Repo.get(User, id)

  def get_user_by_email(email), do: Repo.get_by(User, email: email)

  def update_user(user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def delete_user(user), do: Repo.delete(user)

  def authenticate(user, password) do
    Bcrypt.verify_pass(password, user.password_hash)
  end

  def add_credit(user, amount) do
    Repo.insert(%Credit{user_id: user.id, amount: amount})
  end

  def get_user_total_credits(user) do
    Credit
    |> join(:left, [c], u in assoc(c, :user))
    |> where([_c, u], u.id == ^user.id)
    |> select([c], %{total: sum(c.amount)})
    |> Repo.one()
  end
end
