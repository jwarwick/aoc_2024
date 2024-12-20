defmodule Day05 do
  @moduledoc false

  defstruct rules: Map.new(), reversed_rules: Map.new(), pages: []
  def day() do
    content = File.read!("priv/day05-input.txt")
    |> parseInput()

    p1 = part1(content)
    IO.puts("Part 1: #{p1}")

    p2 = part2(content)
    IO.puts("Part 2: #{p2}")
  end

  def parseInput(input) do
    {rules, pages} = input
    |> String.trim()
    |> String.split(~r/\r\n|\n/)
    |> Enum.split_while(&(&1 != ""))

    {rules, rev_rules} = parseRules(rules, Map.new(), Map.new())
    pages = parsePages(pages)
    %Day05{rules: rules, reversed_rules: rev_rules, pages: pages}
  end

  defp parsePages(pages) do
    pages
    |> Enum.drop(1)
    |> Enum.map(&String.split(&1, ","))
    |> Enum.map(fn x -> Enum.map(x, &String.to_integer/1) end)
  end

  defp parseRules([], rules, reversed_rules), do: {rules, reversed_rules}
  defp parseRules([rule | rest], rules, reversed_rules) do
    [a, b] = rule
    |> String.split("|")
    |> Enum.map(&String.to_integer/1)

    curr = Map.get(rules, a, [])
    rules = Map.put(rules, a, [b | curr])

    curr = Map.get(reversed_rules, b, [])
    reversed_rules = Map.put(reversed_rules, b, [a | curr])

    parseRules(rest, rules, reversed_rules)
  end

  def part1(%Day05{reversed_rules: rev_rules, pages: pages}) do
    pages
    |> Enum.filter(fn x -> is_valid_ordering?(x, rev_rules) end)
    |> Enum.map(&get_middle/1)
    |> Enum.sum()
  end

  defp get_middle(lst) do
    len = length(lst)
    Enum.at(lst, Integer.floor_div(len, 2))
  end

  defp is_valid_ordering?([_last], _rev_rules), do: true
  defp is_valid_ordering?([curr | rest], rev_rules) do
    results = for p <- rest do
      before = Map.get(rev_rules, p, [])
      Enum.member?(before, curr)
    end
    if Enum.all?(results), do: is_valid_ordering?(rest, rev_rules), else: false
  end

  def part2(%Day05{reversed_rules: rev_rules, pages: pages}) do
    pages
    |> Enum.reject(fn x -> is_valid_ordering?(x, rev_rules) end)
    |> Enum.map(fn x -> fix_pages(x, rev_rules) end)
    |> Enum.map(&get_middle/1)
    |> Enum.sum()
  end

  defp fix_pages(x, rev_rules) do
    pages = MapSet.new(x)
    for p <- x do
      before = Map.get(rev_rules, p, []) |> MapSet.new()
      {p, MapSet.intersection(before, pages)}
    end
    |> Enum.sort_by(fn {_, before} -> MapSet.size(before) end)
    |> fix_pages(rev_rules, [])
  end

  defp fix_pages([], _rev_rules, acc), do: Enum.reverse(acc)
  defp fix_pages([{p, _before} | rest], rev_rules, acc) do
    acc = [p | acc]
    remove_set = MapSet.new([p])
    for {p, before} <- rest do
      {p, MapSet.difference(before, remove_set)}
    end
    |> Enum.sort_by(fn {_, before} -> MapSet.size(before) end)
    |> fix_pages(rev_rules, acc)
  end
end
