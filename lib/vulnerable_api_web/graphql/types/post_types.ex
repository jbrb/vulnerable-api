defmodule VulnerableApiWeb.GraphQL.Types.PostTypes do
  use Absinthe.Schema.Notation

  object :post do
    field :id, :string
    field :content, :string
    field :user, :user
    field :comments, list_of(:string)
  end
end
