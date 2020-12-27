defmodule ApiAuthWeb.GenerateTokenController do
  use ApiAuthWeb, :controller

  alias ApiAuthWeb.Auth.Guardian

  def show(conn, _params) do
    conn
    |> put_status(:ok)
    |> render("generate_token.json", token: Guardian.generate_token())
  end

end
