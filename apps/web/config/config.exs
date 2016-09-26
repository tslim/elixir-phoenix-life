# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :game_of_life_web,
  namespace: GameOfLife.Web

# Configures the endpoint
config :game_of_life_web, GameOfLife.Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "yN99ZUL4Yw4xpV5da2blQeHIko2I7ihrF2oj5qcFpLsucbMi8fKPXZAk2PrTqlp0",
  render_errors: [view: GameOfLife.Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: GameOfLife.Web.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
