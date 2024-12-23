defmodule Day11 do
  @moduledoc false
require Integer

  def day() do
    content = File.read!("priv/day11-input.txt")
    |> parseInput()

    p1 = part1(content)
    IO.puts("Part 1: #{p1}")

    p2 = part2(content)
    IO.puts("Part 2: #{p2}")
  end

  def parseInput(input) do
    input
    |> String.split(" ", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Enum.frequencies()
  end

  def part1(content) do
    content
    |> steps(25)
    |> Map.values()
    |> Enum.sum()
  end

  def steps(map, 0), do: map
  def steps(map, n) do
    map
    |> Map.to_list()
    |> Enum.map(fn {val, cnt} -> {List.wrap(step(val)), cnt} end)
    |> Enum.reduce(Map.new(), &update_counts/2)
    |> steps(n-1)
  end

  def update_counts({vals, cnt}, map) do
    vals
    |> Enum.reduce(map, fn val, acc -> Map.update(acc, val, cnt, &(&1 + cnt)) end)
  end

  def step(0), do: 1
  def step(val) do
    digits = Integer.digits(val)
    len = length(digits)
    if rem(len, 2) == 0 do
      half = div(len, 2)
      {first, last} = Enum.split(digits, half)
      [Integer.undigits(first), Integer.undigits(last)]
    else
      val*2024
    end
  end

  def part2(content) do
    content
    |> steps(75)
    |> Map.values()
    |> Enum.sum()
  end
end
