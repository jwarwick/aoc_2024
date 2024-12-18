defmodule Day01Test do
  use ExUnit.Case
  doctest Day01

  test "part1 sample" do
    sample = """
3   4
4   3
2   5
1   3
3   9
3   3
"""
    content = Day01.parseInput(sample)
    assert Day01.part1(content) == 11
  end

  test "part2 sample" do
    sample = """
3   4
4   3
2   5
1   3
3   9
3   3
"""
    content = Day01.parseInput(sample)
    assert Day01.part2(content) == 31
  end
end
