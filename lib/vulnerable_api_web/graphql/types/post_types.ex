defmodule VulnerableApiWeb.GraphQL.Types.PostTypes do
  use Absinthe.Schema.Notation

  alias VulnerableApi.Accounts
  alias VulnerableApi.Comments
  import Absinthe.Resolution.Helpers, only: [dataloader: 1]

  object :post do
    field :id, :string
    field :content, :string
    field :user, :user, resolve: dataloader(Accounts)
    field :comments, list_of(:comment), resolve: dataloader(Comments)
  end
end
