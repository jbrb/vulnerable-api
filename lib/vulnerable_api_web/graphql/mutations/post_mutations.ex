defmodule VulnerableApiWeb.GraphQL.Mutations.PostMutations do
  use Absinthe.Schema.Notation

  alias VulnerableApiWeb.GraphQL.Resolvers.PostResolver

  # alias VulnerableApiWeb.Graphql.Middlewares.AuthorizationMiddleware

  object :post_mutations do
    @desc "Create Post"
    field :create_post, :post do
      arg :user_id, :string
      arg :content, non_null(:string)

      resolve(&PostResolver.create_post/2)
    end

    @desc "Update Post"
    field :update_post, :post do
      arg :post_id, non_null(:string)
      arg :content, non_null(:string)

      resolve(&PostResolver.update_post/2)
    end

    @desc "Delete Post"
    field :delete_post, :post do
      arg :post_id, non_null(:string)

      resolve(&PostResolver.delete_post/2)
    end
  end
end
