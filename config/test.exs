use Mix.Config

config :pastenix, Pastenix.Endpoint,
  http: [port: System.get_env("PORT") || 4001]
