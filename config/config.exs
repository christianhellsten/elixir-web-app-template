# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

#
# App configuration
#
config :web,
  ecto_repos: [ Web.Repo ],
  session: [
    store: :cookie,
    key: "web_session",
    encryption_salt: "12345",
    signing_salt: "67890"
  ],
  secret_key_base: "85E42914D8B810C6C06D72C0BB5C73DB2087AA7B56F2989FEB8BC92E2C87FE38",
  port: System.get_env("PORT") || "4000",
  assets: [
    js: "http://localhost:3333/js/app.js",
    css: "http://localhost:3333/css/app.css"
  ]

#
# Database configuration
#
config :web, Web.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "web"
  #username: "",
  #password: ""

#
# Environment specific configuration
#
import_config "#{Mix.env}.exs"
