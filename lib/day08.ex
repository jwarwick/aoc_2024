defmodule Day08 do
  @moduledoc false

  defstruct arr: %Array2d{}, vals: []

  def day() do
    content = File.read!("priv/day08-input.txt")
    |> parseInput()

    p1 = part1(content)
    IO.puts("Part 1: #{p1}")

    p2 = part2(content)
    IO.puts("Part 2: #{p2}")
  end

  def parseInput(input) do
    arr = Array2d.parse(input)

    vals = arr
    |> Array2d.values()
    |> Enum.map(fn {_, _, v} -> v end)
    |> Enum.uniq()
    |> Enum.reject(&(&1 == "."))

    %Day08{arr: arr, vals: vals}
  end

  def part1(%Day08{arr: arr, vals: vals}) do
    vals
    |> Enum.map(&(find_antinodes(arr, &1)))
    |> List.flatten()
    |> Enum.uniq()
    |> Enum.count()
  end

  defp find_antinodes(arr, val) do
    locs = Array2d.find(arr, val)

    for {a, b, _} <- locs, {c, d, _} <- locs, {a, b} != {c, d} do
      d1 = distance({a, b}, {c, d})
      add({c, d}, d1)
    end
    |> Enum.filter(&(Array2d.valid?(arr, &1)))
  end

  defp distance({a, b}, {c, d}), do: {c-a, d-b}

  defp add({a, b}, {c, d}), do: {a+c, b+d}

  def part2(%Day08{arr: arr, vals: vals}) do
    vals
    |> Enum.map(&(find_resonant(arr, &1)))
    |> List.flatten()
    |> Enum.uniq()
    |> Enum.count()
  end

  defp find_resonant(arr, val) do
    locs = Array2d.find(arr, val)

    for {a, b, _} <- locs, {c, d, _} <- locs, {a, b} != {c, d} do
      {dx, dy} = distance({a, b}, {c, d})
      for idx <- 1..arr.width do
        add({a, b}, {dx*idx, dy*idx})
      end
    end
    |> List.flatten()
    |> Enum.filter(&(Array2d.valid?(arr, &1)))
  end
end
