defmodule Day02Test do
  use ExUnit.Case
  doctest Day02

  describe "Testing the day" do
    setup do
      sample = """
7 6 4 2 1
1 2 7 8 9
9 7 6 2 1
1 3 2 4 5
8 6 4 4 1
1 3 6 7 9
"""
	  [
       content: Day02.parseInput(sample)
    ]
    end

    test "part1 sample", fixture do
      assert Day02.part1(fixture.content) == 2
    end

    test "part2 sample", fixture do
      assert Day02.part2(fixture.content) == 4
    end
  end
end
