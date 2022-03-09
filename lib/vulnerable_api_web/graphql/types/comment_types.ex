defmodule VulnerableApiWeb.GraphQL.Types.CommentTypes do
  use Absinthe.Schema.Notation

  alias VulnerableApi.Accounts
  alias VulnerableApi.Posts
  import Absinthe.Resolution.Helpers, only: [dataloader: 1]

  object :comment do
    field :id, :string
    field :content, :string
    field :user, :user, resolve: dataloader(Accounts)
    field :post, :post, resolve: dataloader(Posts)
  end
end
