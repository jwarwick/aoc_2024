defmodule Array2d do
  @moduledoc """
  Map based 2 dimensional array.
  Upper left corner is (0, 0)
  """

  defstruct nodes: Map.new(), width: 0, height: 0

  def parse(str) do
    lines = String.split(str, ~r{\n|\r\n|\r}, trim: true)
    h = length(lines)
    w = String.length(hd(lines))

    lines
    |> Enum.with_index()
    |> Enum.map(&parse_line/1)
    |> List.flatten()
    |> Enum.reduce(%Array2d{width: w, height: h}, fn {c, r, val}, d -> %Array2d{d | nodes: Map.put(d.nodes, {c, r}, {c, r, val})} end )
  end

  def neighbors(d, {c, r, _}), do: neighbors(d, {c, r})
  def neighbors(%Array2d{nodes: nodes}, {c, r}) do
    for new_c <- c-1..c+1, new_r <- r-1..r+1, {new_c, new_r} != {c, r} do
      Map.get(nodes, {new_c, new_r}, {new_c, new_r, nil})
    end
    |> Enum.reject(fn {_, _, v} -> v == nil end)
  end

  def value(%Array2d{nodes: nodes}, loc = {c, r}, default \\ nil) do
    Map.get(nodes, loc, {c, r, default})
  end

  def values(%Array2d{nodes: nodes}), do: Map.values(nodes)

  defp parse_line({str, row}) do
    vals = String.split(str, "", trim: true) |> Enum.with_index()
    for {v, col} <- vals do
      {col, row, v}
    end
  end
end
