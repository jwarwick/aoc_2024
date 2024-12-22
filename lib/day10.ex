defmodule Day10 do
  @moduledoc false

  def day() do
    content = File.read!("priv/day10-input.txt")
    |> parseInput()

    p1 = part1(content)
    IO.puts("Part 1: #{p1}")

    p2 = part2(content)
    IO.puts("Part 2: #{p2}")
  end

  def parseInput(input) do
    Array2d.parse(input, fn x -> if x == ".", do: 12, else: String.to_integer(x) end)
  end

  def part1(arr = %Array2d{}) do
    arr
    |> Array2d.values()
    |> Enum.filter(fn {_, _, v} -> v == 0 end)
    |> Enum.map(&(get_trails(&1, arr)))
    |> Enum.map(&Enum.count/1)
    |> Enum.sum()
  end

  defp get_trails(start, arr) do
    get_trails([{start, []}], [], arr)
    |> Enum.map(fn {final, _} -> final end)
    |> Enum.uniq()
  end

  defp get_trails([], acc, _arr), do: acc
  defp get_trails([{curr = {x, y, val}, acc} | rest], overall_acc, arr) do
    if val == 9 do
      get_trails(rest, [{{x, y}, Enum.reverse([curr | acc])} | overall_acc], arr)
    else
      neighbors = Array2d.cardinal_neighbors(arr, {x, y, val})
      |> Enum.filter(fn {_, _, v} -> v == val + 1 end)
      |> Enum.map(fn x -> {x, [curr | acc]} end)
      get_trails(rest ++ neighbors, overall_acc, arr)
    end
  end

  def part2(arr) do
    arr
    |> Array2d.values()
    |> Enum.filter(fn {_, _, v} -> v == 0 end)
    |> Enum.map(&(get_trails2(&1, arr)))
    |> Enum.map(&Enum.count/1)
    |> Enum.sum()
  end

  defp get_trails2(start, arr) do
    get_trails([{start, []}], [], arr)
  end
end
