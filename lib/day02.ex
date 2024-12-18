defmodule Day02 do
  @moduledoc false

  def day() do
    content = File.read!("priv/day02-input.txt")
    |> parseInput()

    p1 = part1(content)
    IO.puts("Part 1: #{p1}")

    p2 = part2(content)
    IO.puts("Part 2: #{p2}")
  end

  def part1(content) do
    content
    |> Enum.map(&isSafe?/1)
    |> Enum.count(&(&1 == true))
  end

  def isSafe?(l = [h | rest]) do
    sorted = Enum.sort(l)
    rev_sorted = Enum.reverse(sorted)
    if l == sorted || l == rev_sorted do
      isSafe?(h, rest)
    else
      false
    end
  end
  def isSafe?(_, []), do: true
  def isSafe?(v, [h | rest]) do
    diff = abs(v-h)
    if diff >= 1 && diff <= 3 do
      isSafe?(h, rest)
    else
      false
    end
  end

  def part2(content) do
    content
    |> Enum.map(&(dampener(isSafe?(&1), &1)))
    |> Enum.count(&(&1 == true))
  end

  def dampener(true, _), do: true
  def dampener(false, l) do
      combos = for idx <- 0..length(l)-1 do
        isSafe?(List.delete_at(l, idx))
      end
      Enum.any?(combos)
  end

  def parseInput(input) do
    input
    |> String.split(~r{\n|\r\n}, trim: true)
    |> Enum.map(&(String.split(&1, ~r{\s}, trim: true)))
    |> Enum.map(&(Enum.map(&1, fn x -> String.to_integer(x) end)))
  end
end
