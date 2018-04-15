# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :calculator,
  ecto_repos: [Calculator.Repo]

# Configures the endpoint
config :calculator, CalculatorWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "5asYtZM598sPuIeVzCBP4pXCWXjbVFlFUB9jspKQCcCngasZBnbeXynH6b/KewSa",
  render_errors: [view: CalculatorWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Calculator.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

config :phoenix, :template_engines,
  slim: PhoenixSlime.Engine,
  slime: PhoenixSlime.Engine

config :phoenix_slime, :use_slim_extension, true
