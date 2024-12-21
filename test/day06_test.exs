defmodule Day06Test do
  use ExUnit.Case
  doctest Day06

  describe "Testing the day" do
    setup do
      sample = """
....#.....
.........#
..........
..#.......
.......#..
..........
.#..^.....
........#.
#.........
......#...
"""
	  [
       content: Day06.parseInput(sample)
    ]
    end

    test "part1 sample", fixture do
      assert Day06.part1(fixture.content) == 41
    end

    test "part2 sample", fixture do
      assert Day06.part2(fixture.content) == 6
    end
  end
end
