defmodule Day04Test do
  use ExUnit.Case
  doctest Day04

  describe "Testing the day" do
    setup do
      sample = """
MMMSXXMASM
MSAMXMSMSA
AMXSXMAAMM
MSAMASMSMX
XMASAMXAMM
XXAMMXXAMA
SMSMSASXSS
SAXAMASAAA
MAMMMXMMMM
MXMXAXMASX
"""
	  [
       content: Day04.parseInput(sample)
    ]
    end

    test "part1 sample", fixture do
      assert Day04.part1(fixture.content) == 18
    end

    test "part2 sample", _fixture do
      sample = """
.M.S......
..A..MSMS.
.M.S.MAA..
..A.ASMSM.
.M.S.M....
..........
S.S.S.S.S.
.A.A.A.A..
M.M.M.M.M.
..........
"""
      content = Day04.parseInput(sample)
      assert Day04.part2(content) == 9
    end
  end
end
