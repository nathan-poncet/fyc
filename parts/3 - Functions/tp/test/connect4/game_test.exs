defmodule Connect4.GameTest do
  use ExUnit.Case

  test "create" do
    assert %{status: :lobby} = Connect4.Game.create()
  end

  test "start" do
    assert %{status: :playing} = Connect4.Game.start(%{status: nil})
  end

  test "lobby" do
    assert %{status: :lobby} = Connect4.Game.lobby(%{status: nil})
  end
end
