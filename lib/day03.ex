defmodule Day03 do
  @moduledoc false

  def day() do
    content = File.read!("priv/day03-input.txt")
    |> parseInput()

    p1 = part1(content)
    IO.puts("Part 1: #{p1}")

    p2 = part2(content)
    IO.puts("Part 2: #{p2}")
  end

  def part1(input) do
    Regex.scan(~r{mul\(\d+,\d+\)}, input)
    |> List.flatten()
    |> Enum.map(&parseMul/1)
    |> Enum.sum()
  end

  defp parseMul(str) do
    str
    |> String.trim_leading("mul(")
    |> String.trim_trailing(")")
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
    |> Enum.reduce(1, fn x, acc -> x * acc end)
  end

  def part2(input) do
    {_, rtn} = Regex.scan(~r{mul\(\d+,\d+\)|do\(\)|don't\(\)}, input)
    |> List.flatten()
    |> Enum.reduce({true, 0}, &parseStr/2)
    rtn
  end

  def parseStr("do()", {_state, rtn}), do: {true, rtn}
  def parseStr("don't()", {_state, rtn}), do: {false, rtn}
  def parseStr(_, {false, rtn}), do: {false, rtn}
  def parseStr(mul, {true, rtn}) do
    val = parseMul(mul)
    {true, rtn + val}
  end

  def parseInput(input) do
    input
  end
end
