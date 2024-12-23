defmodule Day11Test do
  use ExUnit.Case
  doctest Day11

  describe "Testing the day" do
    setup do
      sample = "125 17"
	  [
       content: Day11.parseInput(sample)
    ]
    end

    test "part1 sample", fixture do
      assert Day11.part1(fixture.content) == 55312
    end

    test "part2 sample", fixture do
      assert Day11.part2(fixture.content) == 81
    end
  end
end
