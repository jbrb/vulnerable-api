defmodule VulnerableApiWeb.GraphQL.Queries.AccountQueries do
  use Absinthe.Schema.Notation

  alias VulnerableApiWeb.Graphql.Resolvers.AccountResolver

  # alias VulnerableApiWeb.Graphql.Middlewares.AuthorizationMiddleware

  object :account_queries do
    @desc "Get User"
    field :get_user, type: :user do
      arg :user_id, :string

      resolve(&AccountResolver.get_user/2)
    end
  end
end
