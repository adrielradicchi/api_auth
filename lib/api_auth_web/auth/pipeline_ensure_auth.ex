defmodule ApiAuthWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :api_auth

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.VerifySession
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
