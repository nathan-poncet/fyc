defmodule Connect4.Games.InfoTest do
  use ExUnit.Case, async: true

  test "get_random_funfacts_sync/1 returns a list of funfacts" do
    {:ok, funfacts} = Connect4.Games.Info.get_random_funfacts_sync(3)

    assert length(funfacts) == 3
    assert is_list(funfacts)
  end

  test "get_random_funfacts_async/2 (:spawn) returns a list of funfacts" do
    funfacts = Connect4.Games.Info.get_random_funfacts_async(:spawn, 3)

    assert length(funfacts) == 3
    assert is_list(funfacts)
  end

  test "get_random_funfacts_async/2 (:my_task) returns a list of funfacts" do
    funfacts = Connect4.Games.Info.get_random_funfacts_async(:job, 3)

    assert length(funfacts) == 3
    assert is_list(funfacts)
  end

  test "get_random_funfacts_async/2 (:task_async) returns a list of funfacts" do
    funfacts = Connect4.Games.Info.get_random_funfacts_async(:task_async, 3)

    assert length(funfacts) == 3
    assert is_list(funfacts)
  end

  test "get_random_funfacts_async/2 (:task_async_stream) returns a list of funfacts" do
    funfacts = Connect4.Games.Info.get_random_funfacts_async(:task_async_stream, 3)

    assert length(funfacts) == 3
    assert is_list(funfacts)
  end
end
