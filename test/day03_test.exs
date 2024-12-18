defmodule Day03Test do
  use ExUnit.Case
  doctest Day03

  describe "Testing the day" do
    setup do
      sample = "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"
	  [
       content: Day03.parseInput(sample)
    ]
    end

    test "part1 sample", fixture do
      assert Day03.part1(fixture.content) == 161
    end

    test "part2 sample", _fixture do
      sample = "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"
      assert Day03.part2(sample) == 48
    end
  end
end
