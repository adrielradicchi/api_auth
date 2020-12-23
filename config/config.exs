# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :api_auth,
  ecto_repos: [ApiAuth.Repo]

# Configures the endpoint
config :api_auth, ApiAuthWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "SblDuNZAbsIlqgUcYXtUHKknwlEWC2jZof3Pffa2wzJULSNQZanzbIZxWDFJ1uV1",
  render_errors: [view: ApiAuthWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: ApiAuth.PubSub,
  live_view: [signing_salt: "TzoBNJ8s"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

config :api_auth, ApiAuth.Auth.Guardian,
  issuer: "api_auth",
  secret_key: "2QT+CMejyvnFyRPWr7OYHyRciG42ePD3ZIUIip4FqnY3dyKaXJpKfLH4JcErwRDW"

config :api_auth, ApiAuth.Auth.Pipeline,
  module: ApiAuth.Auth.Guardian,
  error_handler: ApiAuth.Auth.ErrorHandler,
  token_type: ["access","refresh"],
  ttl: {1, :day}
