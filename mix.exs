#
# Mix is a build tool that provides tasks for creating, compiling, and testing
# Elixir projects, managing its dependencies, and more.
#
# See https://github.com/hexpm/hex_web/blob/master/mix.exs
#
defmodule Web.Mixfile do
  # In order to configure Mix, a developer needs to use Mix.Project in a module
  # and define a function named project that returns a keyword list with
  # configuration.
  # http://elixir-lang.org/docs/stable/mix/Mix.Project.html
  use Mix.Project

  # Configure project.
  def project do
    [ app: :web,
      version: "0.0.1",
      elixir: "~> 1.2",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps ]
  end

  #
  # Returns applications that should be started.
  #
  # In OTP, application denotes a component implementing some specific
  # functionality, that can be started and stopped as a unit, and which can be
  # re-used in other systems as well.
  # http://erlang.org/doc/man/application.html
  #
  def application do
    [
      # 3rd-party applications
      applications: [
        :eex,
        :logger,
        :postgrex,
        :ecto,
        :cowboy,
        :plug,
        :slime,
        :poison
      ],
      # Own application
      mod: { Web.Supervisor, [] }
    ]
  end

  #
  # Returns project dependencies:
  # https://hex.pm/
  #
  def deps do
    [
      {:cowboy, "~> 1.0.0"}, # Erlang web server
      {:plug, "~> 1.0"}, # Elixir's rack (Ruby), wsgi (Python), servlet (Java) API
      {:slime, ">= 0.12.0"}, # Slim temlates
      {:exrm, "~> 1.0"}, # Deployment
      {:ecto, "~> 2.0.0-beta"}, # ORM
      {:postgrex, "~> 0.11.1"}, # Postgresql driver
      {:poolboy, ">= 1.5.1" }, # Connection pools
      {:poison, "~> 2.1"} # JSON
    ]
  end
end
