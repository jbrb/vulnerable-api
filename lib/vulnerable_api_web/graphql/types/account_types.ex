defmodule VulnerableApiWeb.GraphQL.Types.AccountTypes do
  use Absinthe.Schema.Notation

  import Absinthe.Resolution.Helpers, only: [dataloader: 1]
  alias VulnerableApi.Posts

  object :user do
    field :id, :string
    field :email, :string
    field :full_name, :string
    field :address, :string
    field :government_id, :string
    field :role, :string
    field :status, :string
    field :credits, :integer
    field :is_private, :boolean
    field :username, :string
    field :posts, list_of(:post), resolve: dataloader(Posts)
  end

  object :token do
    field :user_id, :string
    field :token, :string
  end

  object :credit do
    field :id, :string
    field :amount, :integer
  end
end
