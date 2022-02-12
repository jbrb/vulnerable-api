defmodule VulnerableApi.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias VulnerableApi.Accounts.User
  alias VulnerableApi.Comments.Comment

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @attrs ~w(content is_private)a

  schema "posts" do
    field :content, :string
    field :is_private, :boolean, default: false

    belongs_to :user, User
    has_many :comments, Comment

    timestamps()
  end

  def changeset(post, attrs) do
    cast(post, attrs, @attrs)
  end
end
