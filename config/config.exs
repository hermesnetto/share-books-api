# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :share_books_api,
  ecto_repos: [ShareBooksApi.Repo]

# Configures the endpoint
config :share_books_api, ShareBooksApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ZM1ir6GY4jAnATJx/1kMQhkDNgYNfkeTpbQ6LnEby97XGuLygDS8Rjhvo9ExHEev",
  render_errors: [view: ShareBooksApiWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ShareBooksApi.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# configures Guardian
config :share_books_api, ShareBooksApi.Guardian,
  # optional
  allowed_algos: ["HS512"],
  # optional
  verify_module: Guardian.JWT,
  issuer: "ShareBooksApi",
  ttl: {30, :days},
  allowed_drift: 2000,
  # optional
  verify_issuer: true,
  # generated using: JOSE.JWK.generate_key({:oct, 16}) |> JOSE.JWK.to_map |> elem(1)
  secret_key: %{"k" => "3gx0vXjUD2BJ8xfo_aQWIA", "kty" => "oct"},
  serializer: ShareBooksApi.Guardian

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
