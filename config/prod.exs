use Mix.Config

# ## SSL Support
#
# To get SSL working, you will need to set:
#
#     https: [port: 443,
#             keyfile: System.get_env("SOME_APP_SSL_KEY_PATH"),
#             certfile: System.get_env("SOME_APP_SSL_CERT_PATH")]
#
# Where those two env variables point to a file on
# disk for the key and cert.

config :pastenix, Pastenix.Endpoint,
  url: [host: "example.com"],
  http: [port: System.get_env("PORT")],
  secret_key_base: "fJRCZ7m3tVr5lcXt8VE7Ff8ckPuS++eQC0ResSVMKW0LRzc52uCs93eWoTNrcuO7"

config :logger,
  level: :info
