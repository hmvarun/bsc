# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :bsc,
  ecto_repos: [Bsc.Repo]

# Configures the endpoint
config :bsc, Bsc.Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: System.get_env("BSC_SECRET"),
  render_errors: [view: Bsc.Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Bsc.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :guardian, Guardian,
  allowed_algos: ["HS512"], # optional
  verify_module: Guardian.JWT,  # optional
  issuer: "Lysi",
  ttl: {30, :days},
  allowed_drift: 2000,
  verify_issuer: true, # optional
  secret_key: System.get_env("BSC_SECRET"),
  serializer: Bsc.GuardianSerializer

# AWS credentians
config :ex_aws,
  access_key_id: [{:system, "AWS_ACCESS_KEY_ID"}, :instance_role],
  secret_access_key: [{:system, "AWS_SECRET_ACCESS_KEY"}, :instance_role]
# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
