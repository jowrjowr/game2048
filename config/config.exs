# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :game_2048,
  ecto_repos: [Game2048.Repo]

# Configures the endpoint
config :game_2048, Game2048Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "hVvs798ovf2+mPERoeYd2WULEpANr/PQtY8WbYuCaMux3m29kGd3eBVBdMk+uwSl",
  render_errors: [view: Game2048Web.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Game2048.PubSub,
  live_view: [signing_salt: "F9n+2llB"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
