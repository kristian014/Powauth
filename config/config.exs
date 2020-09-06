# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :powauthproject,
  ecto_repos: [Powauthproject.Repo]

# Configures the endpoint
config :powauthproject, PowauthprojectWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "neb8UMykZL1tyxfa07PJqnhx9kcqiNQJ5w/2smjivHKypgDXUfZQ7lPPt3np3icM",
  render_errors: [view: PowauthprojectWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Powauthproject.PubSub,
  live_view: [signing_salt: "YwP6fquX"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# pow configuration
config :powauthproject, :pow,
  user: Powauthproject.Users.User,
  repo: Powauthproject.Repo,
    extensions: [PowPersistentSession, PowResetPassword, PowEmailConfirmation, PowInvitation],
    controller_callbacks: PowauthprojectWeb.Pow.ControllerCallbacks,
   web_module: PowauthprojectWeb
# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
