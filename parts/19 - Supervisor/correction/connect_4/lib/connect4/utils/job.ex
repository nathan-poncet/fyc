defmodule Connect4.Utils.Job do
  @moduledoc """
  A module that provides a simple interface for running functions in separate
  """

  @doc """
  Runs a function in a separate process and returns its result.
  """
  def async(fun) do
    parent = self()

    spawn(fn -> send(parent, {self(), :result, fun.()}) end)
  end

  @doc """
  Waits for the result of a function run in a separate process.
  """
  def await(pid) do
    receive do
      {^pid, :result, value} -> value
    end
  end
end
