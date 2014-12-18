defmodule Pastenix.Endpoint do
  use Phoenix.Endpoint, otp_app: :pastenix

  plug Plug.Static,
    at: "/", from: :pastenix

  plug Plug.Logger

  # Code reloading will only work if the :code_reloader key of
  # the :phoenix application is set to true in your config file.
  plug Phoenix.CodeReloader

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head

  plug Plug.Session,
    store: :cookie,
    key: "_pastenix_key",
    signing_salt: "00AS58+C",
    encryption_salt: "ah83n+L2"

  plug :router, Pastenix.Router
end
