defmodule VulnerableApi.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias VulnerableApi.Accounts.Credit
  alias VulnerableApi.Comments.Comment
  alias VulnerableApi.Posts.Post

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @password_format ~r/^(?=.*[A-Z])(?=.*[!@#$%^&*])(?=.*[0-9])(?=.*[a-z]).{12,}$/

  @attrs ~w(
    email
    full_name
    address
    government_id
    role
    status
    is_private
    password
    password_confirmation
    username
  )a

  schema "users" do
    field :email, :string
    field :full_name, :string
    field :address, :string
    field :government_id, :string
    field :password_reset_token, :string
    field :password_hash, :string
    field :role, :string
    field :status, :string
    field :is_private, :boolean, default: false
    field :username, :string

    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    has_many :posts, Post
    has_many :users, Comment
    has_many :credits, Credit

    timestamps()
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, @attrs)
    |> validate_required([:full_name, :address, :email, :password, :password_confirmation])
    |> validate_confirmation(:password)
    |> validate_length(:password, min: 12)
    |> validate_format(:password, @password_format)
    |> hash_password()
  end

  def update_changeset(user, attrs) do
    user
    |> cast(attrs, [:full_name, :address, :email])
  end

  defp hash_password(%{valid?: true, changes: %{password: password}} = changeset) do
    put_change(changeset, :password_hash, Bcrypt.hash_pwd_salt(password))
  end

  defp hash_password(changeset), do: changeset
end
