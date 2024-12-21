defmodule Day07 do
  @moduledoc false

  defstruct map: nil, curr_loc: {0, 0}, heading: :north, visited: MapSet.new()

  def day() do
    content = File.read!("priv/day07-input.txt")
    |> parseInput()

    p1 = part1(content)
    IO.puts("Part 1: #{p1}")

    p2 = part2(content)
    IO.puts("Part 2: #{p2}")
  end

  def parseInput(input) do
    input
    |> String.split(~r/\n|\r\n|\r/, trim: true)
    |> Enum.map(&(String.split(&1, ": ", trim: true)))
    |> Enum.map(fn [s, l] -> {String.to_integer(s),
                              String.split(l, " ", trim: true)
                              |> Enum.map(&String.to_integer/1)} end)
  end

  def part1(content) do
    content
    |> Enum.map(&compute/1)
    |> Enum.sum()
  end

  defp compute({total, [first | rest]}) do
    {_state, val} = search(total, first, rest)
    val
  end

  defp search(total, curr, []) do
    if total == curr do
      {:ok, total}
    else
      {:error, 0}
    end
  end

  defp search(total, curr, [first | rest]) do
    if curr > total do
      {:error, 0}
    else
      {state, val} = search(total, curr + first, rest)
      if state == :ok do
        {:ok, val}
      else
        search(total, curr * first, rest)
      end
    end
  end

  def part2(content) do
    content
    |> Enum.map(&compute2/1)
    |> Enum.sum()
  end

  defp compute2({total, [first | rest]}) do
    {_state, val} = search2(total, first, rest, [])
    val
  end

  defp search2(total, curr_total, [], _acc) do
    if total == curr_total do
      {:ok, total}
    else
      {:error, 0}
    end
  end

  defp search2(total, curr_total, [first | rest], acc) do
    if curr_total > total do
      {:error, 0}
    else
      {state, val} = search2(total, curr_total + first, rest, [{:+, first} | acc])
      if state == :ok do
        {:ok, val}
      else
        {state, val} = search2(total, curr_total * first, rest, [{:*, first} | acc])
        if state == :ok do
          {:ok, val}
        else
          combined = int_join(curr_total, first)
          {state, val} = search2(total, combined, rest, [{:c, combined} | acc])
          if state == :ok do
            {:ok, val}
          else
            {:error, 0}
          end
        end
      end
    end
  end

  defp int_join(a, b) do
    Integer.to_string(a) <> Integer.to_string(b)
    |> String.to_integer()
  end
end
