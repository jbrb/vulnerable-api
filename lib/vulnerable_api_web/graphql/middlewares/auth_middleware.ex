defmodule VulnerableApiWeb.Graphql.Middlewares.AuthMiddleware do
  @behaviour Absinthe.Middleware
  alias Absinthe.Resolution
  alias VulnerableApi.Accounts.User

  def call(%{context: %{user: %User{}}} = resolution, _config) do
    resolution
  end

  def call(resolution, _config) do
    Resolution.put_result(
      resolution,
      {:error, %{message: "Not authenticated", code: 401}}
    )
  end
end
