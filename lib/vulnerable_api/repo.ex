defmodule VulnerableApi.Repo do
  use Ecto.Repo,
    otp_app: :vulnerable_api,
    adapter: Ecto.Adapters.Postgres
end
