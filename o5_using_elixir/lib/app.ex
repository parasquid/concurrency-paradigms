defmodule App do
  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    # https://github.com/thestonefox/elixir_poolboy_example
    poolboy_config = [
      {:name, {:local, :pool}},
      {:worker_module, Concurrent.Agent},
      {:size, 0},
      {:max_overflow, 20}
    ]

    # Define workers and child supervisors to be supervised
    children = [
      # Starts a worker by calling: Worker.start_link(arg1, arg2, arg3)
      supervisor(Task.Supervisor, [[name: TaskSupervisor]]),
      # worker(Blank.Worker, [arg1, arg2, arg3]),
      :poolboy.child_spec(:pool, poolboy_config, [])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: App.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
