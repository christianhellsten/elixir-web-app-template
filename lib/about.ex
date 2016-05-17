defmodule Web.About do
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
  # Matches request to a route
  plug :match
  # Dispatches request to a route
  plug :dispatch

  #
  # HTTP GET /
  #
  # Use conn.private to access route options:
  #   conn.private[:protected]
  #
  get "/", private: %{protected: false} do
    conn |> send_resp(200, "Noooo")
  end
end
