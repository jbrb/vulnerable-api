defmodule VulnerableApiWeb.GraphQL.Queries.PostQueries do
  use Absinthe.Schema.Notation

  alias VulnerableApiWeb.GraphQL.Resolvers.PostResolver

  # alias VulnerableApiWeb.Graphql.Middlewares.AuthenticationMiddleware
  # alias VulnerableApiWeb.Graphql.Middlewares.AuthorizationMiddleware

  object :post_queries do
    @desc "List Posts"
    field :list_posts, list_of(:post) do
      arg(:user_id, :string)

      # middleware(AuthenticationMiddleware)
      # middleware(AuthorizationMiddleware, ["ADMIN"])
      resolve(&PostResolver.list_posts/2)
    end
  end
end
