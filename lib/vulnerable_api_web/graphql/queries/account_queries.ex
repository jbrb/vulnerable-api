defmodule VulnerableApiWeb.GraphQL.Queries.AccountQueries do
  use Absinthe.Schema.Notation

  alias VulnerableApiWeb.GraphQL.Resolvers.AccountResolver

  # alias VulnerableApiWeb.Graphql.Middlewares.AuthorizationMiddleware

  object :account_queries do
    @desc "Get Current User"
    field :get_current_user, :user do
      arg(:user_id, :string)

      resolve(&AccountResolver.get_user/2)
    end

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

    @desc "Search User"
    field :search_user, list_of(:user) do
      arg(:keyword, non_null(:string))

      resolve(&AccountResolver.search_user/2)
    end

    @desc "List credits"
    field :list_credits_history, list_of(:credit) do
      resolve(&AccountResolver.list_credits_history/2)
    end

    @desc "Get user credits"
    field :get_user_credits, :credit do
      resolve(&AccountResolver.get_user_credits/2)
    end
  end
end
