defmodule Connect4.Games.Supervisor do
  use Supervisor
  require Logger

  def start_link(init_arg) do
    Supervisor.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  def init(_init_arg) do
    Logger.info("Starting the Games Supervisor...")

    children = [
      {DynamicSupervisor, name: __MODULE__.DynamicSupervisor, strategy: :one_for_one},
      {Registry, keys: :unique, name: Connect4.Games.Registry}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end

  def game_create(player, name, settings) do
    case DynamicSupervisor.start_child(
           Connect4.Games.Supervisor.DynamicSupervisor,
           {Connect4.Games.Server, player: player, name: name, settings: settings}
         ) do
      {:ok, pid} ->
        [code] = Registry.keys(Connect4.Games.Registry, pid)
        {:ok, code}

      {:error, reason} ->
        {:error, reason}
    end
  end
end
