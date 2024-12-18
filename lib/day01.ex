defmodule Day01 do
  @moduledoc false

  def day() do
    content = File.read!("priv/day01-input.txt")
    |> parseInput()

    p1 = part1(content)
    IO.puts("Part 1: #{p1}")

    p2 = part2(content)
    IO.puts("Part 2: #{p2}")
  end

  def part1({l, r}) do
    [Enum.sort(l), Enum.sort(r)]
    |> Enum.zip()
    |> Enum.map(fn {x, y} -> abs(x-y) end)
    |> Enum.sum()
  end

  def part2({l, r}) do
    freq = Enum.frequencies(r)

    vals = for v <- l do
      v * Map.get(freq, v, 0)
    end

    Enum.sum(vals)

  end

  def parseInput(input) do
    input
    |> String.split(~r{\n|\r\n}, trim: true)
    |> Enum.map(&(String.split(&1, ~r{\s}, trim: true)))
    |> Enum.reduce({[], []}, fn ([l, r], {lacc, racc}) ->
      {[String.to_integer(l) | lacc], [String.to_integer(r) | racc]}
    end)
  end
end
