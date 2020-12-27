defmodule ApiAuthWeb.GenerateTokenView do
  use ApiAuthWeb, :view

  def render("generate_token.json", %{token: token}), do: %{token: token}

end
