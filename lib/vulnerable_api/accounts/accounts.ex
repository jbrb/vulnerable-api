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

  def search_user(_keyword) do
    User
    # some complex query
    # |> where([u], fragment("SELECT * FROM user u WHERE u.status = '%#{keyword}%')"))
    |> Repo.all()
  end

  def update_user(user, attrs) do
    user
    |> User.update_changeset(attrs)
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
    |> select([c], %{amount: sum(c.amount)})
    |> Repo.one()
  end

  def list_user_credits_history(user) do
    Credit
    |> where(user_id: ^user.id)
    |> Repo.all()
  end

  def send_credits(from, to, amount) do
    add_credit(from, -amount)
    add_credit(to, amount)
  end

  def data() do
    Dataloader.Ecto.new(Repo, query: &query/2)
  end

  def query(queryable, _params) do
    queryable
  end
end
