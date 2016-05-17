use Mix.Config

#
# Assets
#
config :web,
  assets: [
    js: "/js/app.js",
    css: "/css/app.css"
  ]
#
# Database
#
config :web, Web.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "web",
  username: "web",
  password: "password"

#
# Logger
#
#config :logger, :error_log,
  #path: "/var/log/snippets/app.log",
  #level: :info
