defmodule VulnerableApiWeb.GraphQL.Mutations.AccountMutations do
  use Absinthe.Schema.Notation

  alias VulnerableApiWeb.GraphQL.Resolvers.AccountResolver
  alias VulnerableApiWeb.GraphQL.Middlewares.AuthenticationMiddleware
  alias VulnerableApiWeb.GraphQL.Middlewares.RateLimitMiddleware

  object :account_mutations do
    @desc "Sign Up"
    field :sign_up, type: :user do
      arg(:email, non_null(:string))
      arg(:full_name, non_null(:string))
      arg(:address, non_null(:string))
      arg(:password, non_null(:string))
      arg(:password_confirmation, non_null(:string))
      arg(:username, non_null(:string))

      resolve(&AccountResolver.create_user/2)
    end

    @desc "Log In"
    field :login, :token do
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))

      resolve(&AccountResolver.login/2)
    end

    @desc "Update Profile"
    field :update_profile, :user do
      arg(:user_id, :string)
      arg(:email, :string)
      arg(:full_name, non_null(:string))
      arg(:address, non_null(:string))

      middleware(AuthenticationMiddleware)
      resolve(&AccountResolver.update_user/2)
    end

    @desc "Delete User"
    field :delete_user, :user do
      arg(:user_id, non_null(:string))

      resolve(&AccountResolver.delete_user/2)
    end

    @desc "Add Credits"
    field :add_credits, :credit do
      arg(:credits, non_null(:integer))

      resolve(&AccountResolver.add_credits/2)
    end

    @desc "Send credits to user"
    field :send_credits, :credit do
      arg(:email, non_null(:string))
      arg(:credits, non_null(:integer))

      middleware(AuthenticationMiddleware)
      resolve(&AccountResolver.send_credits/2)
    end
  end
end
