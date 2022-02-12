defmodule VulnerableApiWeb.Plugs.Context do
  @behaviour Plug
  import Plug.Conn
  alias VulnerableApi.Accounts
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
         {:ok, %{"sub" => id}} <- Guardian.decode_and_verify(token) do
      {:ok,
       %{
         user: Accounts.get_user(id)
       }}
    else
      [] -> %{}
      error -> error
    end
  end
end
