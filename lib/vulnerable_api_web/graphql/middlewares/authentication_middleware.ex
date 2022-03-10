defmodule VulnerableApiWeb.GraphQL.Middlewares.AuthenticationMiddleware do
  @behaviour Absinthe.Middleware
  alias Absinthe.Resolution
  alias VulnerableApi.Accounts.User

  def call(%{context: %{current_user: %User{}}} = resolution, _any) do
    resolution
  end

  def call(resolution, _any) do
    Resolution.put_result(
      resolution,
      {:error, %{message: "Not authenticated", code: 401}}
    )
  end
end
