defmodule Web.Router do
  #
  # Plug ships with a router that allows developers to quickly match on
  # incoming requests and perform some action:
  # https://hexdocs.pm/plug/readme.html#the-plug-router
  #
  use Plug.Router
  #
  # This module defines a Plug.Conn struct and the main functions for working with Plug connections.
  # https://hexdocs.pm/plug/Plug.Conn.html
  #
  import Plug.Conn
  # Web console
  if Mix.env == :dev do
    use Plug.Debugger
  end
  # Add unique ID to request scope
  plug Plug.RequestId
  # Adds post params to conn.params
  plug Plug.Parsers, parsers: [:multipart, :urlencoded, :json]
  if Mix.env != :test do
    # Sdd session secret required by cookie session
    plug :put_secret_key_base
    # Configure session
    plug Plug.Session, Application.get_env(:web, :session)
    # Initialize session
    plug :fetch_session
    # input name="_method" value="post"
    plug Plug.MethodOverride
    plug Plug.CSRFProtection
  end
  # Parse query parameters
  plug :fetch_query_params
  # Logs request to STDOUT
  plug Plug.Logger, log: :info
  use Controller
  # Define view
  view :index, 'index'

  #
  # Start a GenServer, i.e., a server instance:
  #
  # http://elixir-lang.org/getting-started/mix-otp/genserver.html
  # https://blog.drewolson.org/understanding-gen-server/
  #
  def start_link do
    # Cowboy adapter:
    # https://hexdocs.pm/plug/Plug.Adapters.Cowboy.html
    {:ok, _} = Plug.Adapters.Cowboy.http Web.Router, []
  end

  #
  # HTTP GET /
  #
  # Use conn.private to access route options:
  #   conn.private[:protected]
  #
  get "/", private: %{protected: false} do
    conn
    |> assign(:text, "Hello world")
    |> render(:index, title: "Index")
  end

  get "/favicon.ico" do
    conn |> send_resp(200, "LOL")
  end

  # Forward request to another router.
  #
  # Note that the plugs defined here are executed before the request is
  # forwarded. This means, for example, that the Logger and CSRFProtection
  # plugs must only be defined in lib/router.ex, otherwise the plugs are
  # executed twice.
  forward "/about", to: Web.About

  #
  # A catch-all route
  #
  match _ do
    conn
    |> render(:not_found, title: "Not Found - 404")
  end

  #
  # Plug docs: Since this store uses crypto features, it requires you to
  # set the `:secret_key_base` field in your connection. This
  # can be easily achieved with a plug:
  #
  defp put_secret_key_base(conn, _) do
    put_in conn.secret_key_base, Application.get_env(:web, :secret_key_base)
  end
end
