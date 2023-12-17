defmodule Connect4.GameTest do
  use ExUnit.Case

  test "create" do
    assert %{status: :lobby} = Connect4.Game.create()
  end

  test "start" do
    assert %{status: :playing} = Connect4.Game.start(%{status: :lobby})
  end

  test "start with wrong status" do
    assert_raise FunctionClauseError, fn -> Connect4.Game.start(%{status: nil}) end
  end

  test "stop" do
    assert %{status: :game_over} = Connect4.Game.stop(%{status: :playing})
  end

  test "stop with wrong status" do
    assert_raise FunctionClauseError, fn -> Connect4.Game.stop(%{status: nil}) end
  end
end
