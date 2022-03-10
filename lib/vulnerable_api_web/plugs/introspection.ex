defmodule VulnerableApiWeb.Plugs.Introspection do
  @behaviour Plug
  import Plug.Conn

  def init(opts), do: opts

  def call(%{params: %{"query" => query}} = conn, _args) do
    case String.contains?(query, "__schema") do
      true ->
        conn
        |> put_resp_content_type("text/plain")
        |> send_resp(400, "Bad Request")
        |> halt

      false ->
        conn
    end
  end

  def call(conn, _), do: conn
end
