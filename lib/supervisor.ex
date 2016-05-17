#
# A supervisor is a process which supervises other processes, called child
# processes. Supervisors are used to build a hierarchical process structure
# called a supervision tree, a nice way to structure fault-tolerant applications.
#
# http://elixir-lang.org/docs/stable/elixir/Supervisor.html
#
defmodule Web.Supervisor do
  #
  # In Elixir (actually, in Erlang/OTP), an application is a component
  # implementing some specific functionality, that can be started and stopped as a
  # unit, and which can be re-used in other systems.
  # http://elixir-lang.org/docs/stable/elixir/Application.html
  # http://erlang.org/doc/man/application.html
  # http://erlang.org/doc/design_principles/applications.html
  #
  use Application

  #
  # The type argument passed to start/2 is usually :normal unless in a
  # distributed setup where application takeovers and failovers are configured.
  #
  # start/2 typically returns {:ok, pid} or {:ok, pid, state} where pid
  # identifies the supervision tree and state is the application state.
  #
  def start(_type, _args) do
    #
    # Convenience functions for defining a supervision specification.
    # http://elixir-lang.org/docs/stable/elixir/Supervisor.Spec.html
    #
    import Supervisor.Spec, warn: false
    # A list of children (workers or supervisors) to supervise
    children = [
      worker(Web.Router, [])
    ]
    #
    # If a child process terminates, only that process is restarted:
    # http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    #
    opts = [strategy: :one_for_one, name: Web.Supervisor]
    #
    # Start supervisor by passing the children to start_link/2.
    # You may want to use a module-based supervisor.
    Supervisor.start_link(children, opts)
  end
end
