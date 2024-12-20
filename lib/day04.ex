defmodule Day04 do
  @moduledoc false

  def day() do
    content = File.read!("priv/day04-input.txt")
    |> parseInput()

    p1 = part1(content)
    IO.puts("Part 1: #{p1}")

    p2 = part2(content)
    IO.puts("Part 2: #{p2}")
  end

  def parseInput(input) do
    Array2d.parse(input)
  end

  def part1(arr = %Array2d{}) do
    Array2d.values(arr)
    |> Enum.filter(fn {_, _, v} -> v == "X" end)
    |> Enum.map(&(make_directions(&1, 4)))
    |> Enum.map(&(Enum.map(&1, fn r -> Enum.map(r, fn pt -> Array2d.value(arr, pt, "Z") end) end)))
    |> Enum.map(&(Enum.map(&1, fn r -> Enum.map(r, fn {_, _, v} -> v end) end)))
    |> Enum.map(&(Enum.map(&1, fn x -> Enum.join(x) end)))
    |> List.flatten()
    |> Enum.filter(&(&1 == "XMAS"))
    |> Enum.count()
  end

  defp make_directions({x, y, _}, len) do
    [make_vector({x, y}, [], fn {x,y} -> {x,y-1} end, len),
    make_vector({x, y}, [], fn {x,y} -> {x+1,y-1} end, len),
    make_vector({x, y}, [], fn {x,y} -> {x+1,y} end, len),
    make_vector({x, y}, [], fn {x,y} -> {x+1,y+1} end, len),
    make_vector({x, y}, [], fn {x,y} -> {x,y+1} end, len),
    make_vector({x, y}, [], fn {x,y} -> {x-1,y+1} end, len),
    make_vector({x, y}, [], fn {x,y} -> {x-1,y} end, len),
    make_vector({x, y}, [], fn {x,y} -> {x-1,y-1} end, len)]
  end

  defp make_vector({_x, _y}, acc, _f, 0), do: Enum.reverse(acc)
  defp make_vector(curr, acc, f, len) do
    make_vector(f.(curr), [curr | acc], f, len-1)
  end

  def part2(arr = %Array2d{}) do
    Array2d.values(arr)
    |> Enum.filter(fn {_, _, v} -> v == "A" end)
    |> Enum.map(&(get_x_neighbors(arr, &1)))
    |> Enum.map(&(Enum.map(&1, fn {_, _, v} -> v end)))
    |> Enum.map(&(Enum.join(&1)))
    |> Enum.filter(&valid_xmas?/1)
    |> Enum.count()
  end

  defp valid_xmas?("SSMM"), do: true
  defp valid_xmas?("MSSM"), do: true
  defp valid_xmas?("MMSS"), do: true
  defp valid_xmas?("SMMS"), do: true
  defp valid_xmas?(_), do: false

  defp get_x_neighbors(arr, {x, y, _}) do
    [
      Array2d.value(arr, {x-1, y-1}, "Z"),
      Array2d.value(arr, {x+1, y-1}, "Z"),
      Array2d.value(arr, {x+1, y+1}, "Z"),
      Array2d.value(arr, {x-1, y+1}, "Z")
    ]
  end
end
