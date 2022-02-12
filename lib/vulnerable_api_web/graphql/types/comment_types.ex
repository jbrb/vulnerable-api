defmodule VulnerableApiWeb.GraphQL.Types.CommentTypes do
  use Absinthe.Schema.Notation

  object :comment do
    field :id, :string
    field :content, :string
    field :user, :user
  end
end
