defmodule VulnerableApiWeb.GraphQL.Middlewares.RateLimitMiddleware do
  @behaviour Absinthe.Middleware
  alias Absinthe.Resolution

  def call(%{errors: [%{message: _} | _]} = resolution, _any), do: resolution

  def call(%{error: error} = resolution, _any) do
    Resolution.put_result(resolution, {:error, %{message: error}})
  end

  def call(%{context: %{error: error}} = resolution, _any) do
    Resolution.put_result(resolution, {:error, %{message: error}})
  end

  # raw
  def call(%{arguments: %{email: email, password: _}} = resolution, _any) do
    case ExRated.check_rate("login:#{email}", 60_000, 5) do
      {:ok, _} ->
        resolution

      {:error, _} ->
        Resolution.put_result(
          resolution,
          {:error, %{message: "You have reached limit. Please try again later."}}
        )
    end

    #
    limit(resolution, "login:#{email}", 60_000, 5)
  end

  # dynamic
  def call(
        %{
          definition: %{
            schema_node: %{
              name: request_name
            }
          },
          context: %{
            current_user: %{
              id: user_id
            }
          }
        } = resolution,
        %{
          interval: interval,
          limit: limit
        }
      ) do
    case ExRated.check_rate("#{request_name}:#{user_id}", interval, limit) do
      {:ok, _} ->
        resolution

      {:error, _} ->
        Resolution.put_result(
          resolution,
          {:error, %{message: "You have reached limit. Please try again later."}}
        )
    end

    # request_name = request_name(resolution)
    # limit(resolution, "#{request_name}:#{user_id}", interval, limit)
  end

  defp limit(resolution, id, interval, limit) do
    case ExRated.check_rate(id, interval, limit) do
      {:ok, _} ->
        resolution

      {:error, _} ->
        Resolution.put_result(
          resolution,
          {:error, %{message: "You have reached limit. Please try again later."}}
        )
    end
  end
end
