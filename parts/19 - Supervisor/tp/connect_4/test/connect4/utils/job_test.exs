defmodule Connect4.Utils.JobTest do
  use ExUnit.Case, async: true

  test "async/1 spawns a process and returns its pid" do
    pid = Connect4.Utils.Job.async(fn -> :ok end)

    assert pid
    assert pid != self()
  end

  test "await/1 waits for the result of a process" do
    pid = Connect4.Utils.Job.async(fn -> :ok end)

    assert Connect4.Utils.Job.await(pid) == :ok
  end
end
