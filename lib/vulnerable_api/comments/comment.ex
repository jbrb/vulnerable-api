defmodule VulnerableApi.Comments.Comment do
  use Ecto.Schema
  import Ecto.Changeset
  alias VulnerableApi.Accounts.User
  alias VulnerableApi.Posts.Post

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @attrs ~w(content)a

  schema "comments" do
    field :content, :string

    belongs_to :post, Post
    belongs_to :user, User

    timestamps()
  end

  def changeset(comment, attrs) do
    cast(comment, attrs, @attrs)
  end
end
