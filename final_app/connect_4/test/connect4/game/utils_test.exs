defmodule Game.UtilsTest do
  alias Connect4.Game.Utils
  use ExUnit.Case
  use Patch, only: [:expose, :private]

  setup do
    expose(Utils, validate_input: 1)
  end

  test "validate right user input" do
    Enum.each([{"7 ", 7}, {"  23", 23}], fn {input, expected_output} ->
      assert {:ok, expected_output} == private(Utils.validate_input(input))
    end)

    for i <- 1..100 do
      assert {:ok, i} == private(Utils.validate_input("#{i}"))
    end
  end

  test "validate wrong user input" do
    Enum.each(["21a1", "8ds", "a", "a1", "fcsda", "a1a", "a1a1", "", " ", "7 78"], fn input ->
      assert {:error, :invalid_input} == private(Utils.validate_input(input))
    end)
  end
end
