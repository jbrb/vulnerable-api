defmodule VulnerableApiWeb.GraphQL.Queries.AccountQueries do
  use Absinthe.Schema.Notation

  alias VulnerableApiWeb.GraphQL.Resolvers.AccountResolver

  # alias VulnerableApiWeb.Graphql.Middlewares.AuthorizationMiddleware

  object :account_queries do
    @desc "List Users"
    field :list_users, list_of(:user) do
      resolve(&AccountResolver.list_users/2)
    end

    @desc "Get User"
    field :get_user, :user do
      arg(:user_id, :string)

      resolve(&AccountResolver.get_user/2)
    end

    @desc "View Profile"
    field :view_profile, :user do
      arg(:user_id, :string)

      resolve(&AccountResolver.get_user/2)
    end
  end
end
