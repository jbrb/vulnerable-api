defmodule VulnerableApiWeb.GraphQL.Schema do
  @moduledoc """
  Holds schema, queries and mutations for graphQL endpoint
  """
  use Absinthe.Schema

  alias VulnerableApi.Accounts
  alias VulnerableApi.Comments
  alias VulnerableApi.Posts

  alias VulnerableApiWeb.GraphQL.Mutations.{
    AccountMutations,
    CommentMutations,
    PostMutations
  }

  alias VulnerableApiWeb.GraphQL.Queries.{
    AccountQueries,
    PostQueries
  }

  alias VulnerableApiWeb.GraphQL.Types.{
    AccountTypes,
    CommentTypes,
    PostTypes
  }

  # Types imports
  import_types(AccountTypes)
  import_types(CommentTypes)
  import_types(PostTypes)

  # Queries imports
  import_types(AccountQueries)
  import_types(PostQueries)

  # Mutations imports
  import_types(AccountMutations)
  import_types(CommentMutations)
  import_types(PostMutations)

  query do
    import_fields(:account_queries)
    import_fields(:post_queries)
  end

  mutation do
    import_fields(:account_mutations)
    import_fields(:comment_mutations)
    import_fields(:post_mutations)
  end

  def context(ctx) do
    loader =
      Dataloader.new()
      |> Dataloader.add_source(Accounts, Accounts.data())
      |> Dataloader.add_source(Comments, Comments.data())
      |> Dataloader.add_source(Posts, Posts.data())

    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end
end
