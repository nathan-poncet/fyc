defmodule Connect4.Utils.GenericServer do
  require Logger

  @moduledoc """
  A generic server implementation that can be used to implement a server
  """

  @doc """
  Starts a server with the given callback module and initial state.
  """
  def start(callback_module, initial_state, name) do
    pid = spawn(__MODULE__, :listen_loop, [:init, initial_state, callback_module])
    Process.register(pid, name)

    pid
  end

  @doc """
  Calls a server with the given message and returns the response.
  """
  def call(pid, message) do
    send(pid, {:call, self(), message})

    receive do
      {:response, response} -> response
    end
  end

  @doc """
  Casts a message to a server.
  """
  def cast(pid, message) do
    send(pid, {:cast, message})
  end

  @doc """
  The main loop of the server.
  """
  def listen_loop(:init, state, callback_module) do
    case Kernel.function_exported?(callback_module, :init, 1) do
      true ->
        {:ok, new_state} = callback_module.init(state)
        listen_loop(new_state, callback_module)

      false ->
        listen_loop(state, callback_module)
    end
  end

  def listen_loop(state, callback_module) do
    receive do
      {:call, sender, message} when is_pid(sender) ->
        {response, new_state} = callback_module.handle_call(message, state)
        send(sender, {:response, response})
        listen_loop(new_state, callback_module)

      {:cast, message} ->
        new_state = callback_module.handle_cast(message, state)
        listen_loop(new_state, callback_module)

      unexpected ->
        Logger.error("Unexpected message: #{inspect(unexpected)}")
        listen_loop(state, callback_module)
    end
  end
end
