defmodule VulnerableApiWeb.GraphQL.Schema do
  @moduledoc """
  Holds schema, queries and mutations for graphQL endpoint
  """
  use Absinthe.Schema

  alias VulnerableApiWeb.GraphQL.Mutations.{
    AccountMutations
  }

  alias VulnerableApiWeb.GraphQL.Queries.AccountQueries

  alias VulnerableApiWeb.GraphQL.Types.{
    AccountTypes
  }


  # Types imports
  import_types(AccountTypes)

  # Queries imports
  import_types(AccountQueries)

  # Mutations imports
  import_types(AccountMutations)

  query do
    import_fields(:account_queries)
  end

  mutation do
    import_fields(:account_mutations)
  end
end
