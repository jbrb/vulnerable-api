defmodule VulnerableApiWeb.GraphQL.Mutations.CommentMutations do
  use Absinthe.Schema.Notation

  alias VulnerableApiWeb.GraphQL.Resolvers.CommentResolver

  # alias VulnerableApiWeb.Graphql.Middlewares.AuthorizationMiddleware

  object :comment_mutations do
    @desc "Create Comment"
    field :create_comment, :comment do
      arg(:user_id, :string)
      arg(:content, non_null(:string))
      arg(:post_id, non_null(:string))

      resolve(&CommentResolver.create_comment/2)
    end

    @desc "Update Comment"
    field :update_comment, :comment do
      arg(:comment_id, non_null(:string))
      arg(:content, non_null(:string))

      resolve(&CommentResolver.update_comment/2)
    end

    @desc "Delete Comment"
    field :delete_comment, :comment do
      arg(:comment_id, non_null(:string))

      resolve(&CommentResolver.delete_comment/2)
    end
  end
end
