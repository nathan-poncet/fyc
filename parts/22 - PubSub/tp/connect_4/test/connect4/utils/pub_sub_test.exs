defmodule Connect4.Utils.PubSubTest do
  alias Connect4.Utils.PubSub
  use ExUnit.Case, async: true

  setup_all %{} do
    {:ok, pid} = PubSub.start_link([])
    {:ok, pid: pid}
  end

  test "subscribe" do
    assert {:ok, _pid} = PubSub.subscribe("topic")
  end

  test "unsubscribe" do
    assert :ok = PubSub.unsubscribe("topic")
  end

  test "broadcast" do
    assert :ok = PubSub.broadcast("topic", "message")
  end
end
