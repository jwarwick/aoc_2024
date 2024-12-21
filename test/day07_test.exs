defmodule Day07Test do
  use ExUnit.Case
  doctest Day07

  describe "Testing the day" do
    setup do
      sample = """
190: 10 19
3267: 81 40 27
83: 17 5
156: 15 6
7290: 6 8 6 15
161011: 16 10 13
192: 17 8 14
21037: 9 7 18 13
292: 11 6 16 20
"""
	  [
       content: Day07.parseInput(sample)
    ]
    end

    test "part1 sample", fixture do
      assert Day07.part1(fixture.content) == 3749
    end

    test "part2 sample", fixture do
      assert Day07.part2(fixture.content) == 11387
    end
  end
end
