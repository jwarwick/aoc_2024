defmodule Day09Test do
  use ExUnit.Case
  doctest Day09

  describe "Testing the day" do
    setup do
      sample = "2333133121414131402"
	  [
       content: Day09.parseInput(sample)
    ]
    end

    test "part1 sample", fixture do
      assert Day09.part1(fixture.content) == 1928
    end

    test "part2 sample", fixture do
      assert Day09.part2(fixture.content) == 2858
    end
  end
end
