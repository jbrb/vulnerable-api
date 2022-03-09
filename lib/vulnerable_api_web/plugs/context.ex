defmodule VulnerableApiWeb.Plugs.Context do
  @behaviour Plug
  import Plug.Conn
  alias VulnerableApi.Guardian

  def init(opts), do: opts

  def call(conn, _) do
    case build_context(conn) do
      {:ok, context} ->
        put_private(conn, :absinthe, %{context: context})

      _ ->
        put_private(
          conn,
          :absinthe,
          %{context: %{}}
        )
    end
  end

  defp build_context(conn) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         {:ok, claims} <- Guardian.decode_and_verify(token) do

      {:ok, %{current_user: Guardian.resource_from_claims(claims)}}
    else
      [] -> %{}
      error -> error
    end
  end
end
