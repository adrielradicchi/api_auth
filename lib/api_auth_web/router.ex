defmodule ApiAuthWeb.Router do
  use ApiAuthWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug ApiAuthWeb.Auth.Pipeline
  end

  scope "/api", ApiAuthWeb do
    pipe_through [:api, :auth]

    resources "/users", UsersController, only: [:show, :delete, :update]
    post "/users/signout", UsersController, :sign_out
  end

  scope "/api", ApiAuthWeb do
    pipe_through :api

    post "/users", UsersController, :create
    get "/generatetoken", GenerateTokenController, :show
    post "/users/signin", UsersController, :sign_in
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/api" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: ApiAuthWeb.Telemetry
    end
  end
end
