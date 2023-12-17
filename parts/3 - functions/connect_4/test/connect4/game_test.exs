defmodule Connect4.GameTest do
  use ExUnit.Case

  test "create" do
    assert %{status: :lobby} = Connect4.Game.create()
  end

  test "start" do
    assert %{status: :playing} = Connect4.Game.start(%{status: nil})
  end

  test "stop" do
    assert %{status: :game_over} = Connect4.Game.stop(%{status: nil})
  end
end
