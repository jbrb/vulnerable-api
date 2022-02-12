defmodule VulnerableApiWeb.GraphQL.Mutations.AccountMutations do
  use Absinthe.Schema.Notation

  alias VulnerableApiWeb.Graphql.Resolvers.AccountResolver

  # alias VulnerableApiWeb.Graphql.Middlewares.AuthorizationMiddleware

  object :account_mutations do
    @desc "Sign Up"
    field :sign_up, type: :user do
      arg :email, non_null(:string)
      arg :full_name, non_null(:string)
      arg :address, non_null(:string)
      arg :password, non_null(:string)
      arg :password_confirmation, non_null(:string)

      resolve(&AccountResolver.create_user/2)
    end
  end
end
