defmodule VulnerableApiWeb.GraphQL.Queries.PostQueries do
  use Absinthe.Schema.Notation

  alias VulnerableApiWeb.GraphQL.Resolvers.PostResolver

  # alias VulnerableApiWeb.Graphql.Middlewares.AuthorizationMiddleware

  object :post_queries do
    @desc "List Posts"
    field :list_posts, list_of(:post) do
      arg(:user_id, :string)

      resolve(&PostResolver.list_posts/2)
    end
  end
end
