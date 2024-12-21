defmodule Day06 do
  @moduledoc false

  defstruct map: nil, curr_loc: {0, 0}, heading: :north, visited: MapSet.new()

  def day() do
    content = File.read!("priv/day06-input.txt")
    |> parseInput()

    p1 = part1(content)
    IO.puts("Part 1: #{p1}")

    p2 = part2(content)
    IO.puts("Part 2: #{p2}")
  end

  def parseInput(input) do
    arr = Array2d.parse(input)
    {x, y, _} = Array2d.find(arr, "^") |> hd() # assume always start facing north
    x_arr = Array2d.transform_nodes(arr, fn x -> if x == "#" do true else false end end)
    %Day06{map: x_arr, curr_loc: {x, y}, heading: :north}
  end

  def part1(d = %Day06{}) do
    d
    |> walk([])
    |> Enum.uniq()
    |> length()
  end

  defp walk(d = %Day06{map: map}, acc) do
    {new_curr, new_heading} = take_step(d)
    if Array2d.valid?(map, new_curr) do
      walk(%Day06{d | curr_loc: new_curr, heading: new_heading}, [new_curr | acc])
    else
      Enum.reverse(acc)
    end
  end

  defp take_step(d = %Day06{map: map, curr_loc: curr, heading: heading}) do
    {x, y, _} = Array2d.value(map, step(curr, heading))
    {_, _, blocked} = Array2d.value(map, {x, y}, false)
    if blocked do
      new_heading = turn(heading)
      take_step(%Day06{d | heading: new_heading})
    else
      {{x, y}, heading}
    end
  end

  defp step({x, y}, :north), do: {x, y-1}
  defp step({x, y}, :south), do: {x, y+1}
  defp step({x, y}, :east), do: {x+1, y}
  defp step({x, y}, :west), do: {x-1, y}

  defp turn(:north), do: :east
  defp turn(:east), do: :south
  defp turn(:south), do: :west
  defp turn(:west), do: :north

  def part2(d = %Day06{}) do
    path = d
    |> walk([])
    |> Enum.uniq()
    |> List.delete(d.curr_loc)

    for p <- path do
      walk_loop_check(%Day06{d | map: Array2d.put(d.map, p, true)})
    end
    |> Enum.filter(fn x -> x == true end)
    |> Enum.count()
  end

  defp walk_loop_check(d = %Day06{map: map, visited: visited}) do
    {new_curr, new_heading} = take_step(d)
    if Array2d.valid?(map, new_curr) do
      if MapSet.member?(visited, {new_curr, new_heading}) do
        true
      else
        walk_loop_check(%Day06{d | curr_loc: new_curr,
                                heading: new_heading,
                                visited: MapSet.put(visited, {new_curr, new_heading})})
      end
    else
      false
    end
  end

end
