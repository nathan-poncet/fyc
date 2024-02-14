defmodule Connect4.Utils.GenericServerTest do
  alias Connect4.Utils.GenericServer
  use ExUnit.Case

  test "start/3 starts a process and returns its pid" do
    pid = GenericServer.start(__MODULE__, :ok, __MODULE__)

    assert pid != nil

    Process.exit(pid, :kill)
  end

  test "call/2 calls a function in a process" do
    pid = GenericServer.start(__MODULE__, :ok, __MODULE__)

    assert GenericServer.call(pid, :ok) == :ok

    Process.exit(pid, :kill)
  end

  test "cast/2 casts a function in a process" do
    pid = GenericServer.start(__MODULE__, :ok, __MODULE__)

    assert GenericServer.cast(pid, :ok) == {:cast, :ok}

    Process.exit(pid, :kill)
  end

  def handle_call(:ok, state) do
    {:ok, state}
  end

  def handle_cast(:ok, state) do
    state
  end
end
