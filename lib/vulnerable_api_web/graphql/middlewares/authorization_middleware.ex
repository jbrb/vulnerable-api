defmodule VulnerableApiWeb.Graphql.Middlewares.AuthorizationMiddleware do
  @behaviour Absinthe.Middleware
  alias Absinthe.Resolution

  def call(%{errors: [%{message: _} | _]} = resolution, _config), do: resolution

  def call(%{context: %{current_user: user}} = resolution, allowed_roles) do
    if user.role in allowed_roles do
      resolution
    else
      return_unauthorized(resolution)
    end
  end

  def call(resolution, _config), do: return_unauthorized(resolution)

  defp return_unauthorized(resolution) do
    Resolution.put_result(
      resolution,
      {:error, %{message: "Unauthorized.", code: 403}}
    )
  end
end
