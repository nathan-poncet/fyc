defmodule Connect4.Games.Supervisor do
  use Supervisor
  require Logger

  def start_link(init_arg) do
    Supervisor.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  def init(_init_arg) do
    Logger.info("Starting the Games Supervisor...")

    children = []

    Supervisor.init(children, strategy: :one_for_one)
  end
end
