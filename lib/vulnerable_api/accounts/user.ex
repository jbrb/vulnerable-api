defmodule VulnerableApi.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias VulnerableApi.Comments.Comment
  alias VulnerableApi.Posts.Post

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @attrs ~w(email full_name address government_id role status credits is_private)a

  schema "users" do
    field :email, :string
    field :full_name, :string
    field :address, :string
    field :government_id, :string
    field :password_reset_token, :string
    field :password_hash, :string
    field :role, :string
    field :status, :string
    field :credits, :integer
    field :is_private, :boolean, default: false

    field :password, :string, virtual: true

    has_many :posts, Post
    has_many :users, Comment

    timestamps()
  end

  def changeset(user, attrs) do
    cast(user, attrs, @attrs)
  end
end
