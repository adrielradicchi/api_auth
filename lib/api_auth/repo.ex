defmodule ApiAuth.Repo do
  use Ecto.Repo,
    otp_app: :api_auth,
    adapter: Ecto.Adapters.Postgres
end
