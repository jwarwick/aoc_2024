defmodule Day10Test do
  use ExUnit.Case
  doctest Day10

  describe "Testing the day" do
    setup do
      sample = """
89010123
78121874
87430965
96549874
45678903
32019012
01329801
10456732
"""
	  [
       content: Day10.parseInput(sample)
    ]
    end

    test "part1 sample", fixture do
      assert Day10.part1(fixture.content) == 36
    end

    test "part2 sample", fixture do
      assert Day10.part2(fixture.content) == 81
    end
  end
end
