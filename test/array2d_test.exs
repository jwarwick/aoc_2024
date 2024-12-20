defmodule Array2dTest do
  use ExUnit.Case
  doctest Array2d

  describe "Simple creation" do
    setup do
      sample = """
ABCD
EFGH
"""
	  [
       sample: sample
    ]
    end

    test "2x4", fixture do
      a = Array2d.parse(fixture.sample)
      assert a.width == 4
      assert a.height == 2
      assert length(Map.values(a.nodes)) == 8

      pt = {0, 0}
      n = Array2d.neighbors(a, pt)
      assert length(n) == 3
      s = MapSet.new(n)
      assert MapSet.member?(s, {1, 0, "B"}) == true
      assert MapSet.member?(s, {0, 1, "E"}) == true
      assert MapSet.member?(s, {1, 1, "F"}) == true

      pt = {0, 0, "A"}
      n = Array2d.neighbors(a, pt)
      assert length(n) == 3

      pt = {1, 1}
      n = Array2d.neighbors(a, pt)
      assert length(n) == 5

      assert Array2d.value(a, {0, 0}) == {0, 0, "A"}
      assert Array2d.value(a, {9, 9}) == {9, 9, nil}
      assert Array2d.value(a, {-1, 9}, "Z") == {-1, 9, "Z"}
    end
  end
end
