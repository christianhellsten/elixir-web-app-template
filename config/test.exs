# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :web, Web.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "web_test",
  #username: "",
  #password: ""
  pool: Ecto.Adapters.SQL.Sandbox
