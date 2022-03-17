defmodule VulnerableApiWeb.CreditsController do
  use VulnerableApiWeb, :controller

  alias VulnerableApi.Accounts

  def send_credits(conn, params) do
    user =
      case conn.private[:absinthe] do
        %{context: %{current_user: user}} ->
          user

        _ ->
          nil
      end

    %{"from" => user.email}
    |> Map.merge(params)
    |> send_money(conn)
  end

  def send_money(%{"from" => from, "to" => to, "amount" => amount}, conn) do
    from = Accounts.get_user_by_email(from)
    to = Accounts.get_user_by_email(to)

    Accounts.send_credits(from, to, String.to_integer(amount))

    send_resp(conn, 200, "successfully sent")
  end
end
