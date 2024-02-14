defmodule Connect4.Utils.PubSub do
  @moduledoc """
  This module contains the pubsub logic.
  """
  use Supervisor
  require Logger

  def start_link(init_arg) do
    Supervisor.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  def init(_init_arg) do
    Logger.info("Starting the PubSub Supervisor...")

    children = [
      {Registry, keys: :duplicate, name: __MODULE__.Registry}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end

  @doc """
  This function is used to subscribe to a topic.
  """
  def subscribe(topic) do
    Registry.register(__MODULE__.Registry, topic, [])
  end

  @doc """
  This function is used to unsubscribe from a topic.
  """
  def unsubscribe(topic) do
    Registry.unregister(__MODULE__.Registry, topic)
  end

  @doc """
  This function is used to publish a message to a topic.
  """
  def broadcast(topic, message) do
    Registry.dispatch(__MODULE__.Registry, topic, fn entries ->
      for {pid, _} <- entries, do: send(pid, {:broadcast, message})
    end)
  end
end
