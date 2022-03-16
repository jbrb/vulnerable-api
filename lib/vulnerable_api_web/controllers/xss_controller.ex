defmodule VulnerableApiWeb.Controllers.XssController do
  use VulnerableApiWeb, :controller
  alias VulnerableApi.Utils.XssHandler

  def xss(conn, params) do
    XssHandler.exec(params)

    conn
    |> resp(200, "haxx3d")
    |> send_resp()
  end
end
