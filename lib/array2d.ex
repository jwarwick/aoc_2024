defmodule Array2d do
  @moduledoc """
  Map based 2 dimensional array.
  Upper left corner is (0, 0)
  """

  defstruct nodes: Map.new(), width: 0, height: 0

  def parse(str, transform \\ fn x -> x end) do
    lines = String.split(str, ~r{\n|\r\n|\r}, trim: true)
    h = length(lines)
    w = String.length(hd(lines))

    lines
    |> Enum.with_index()
    |> Enum.map(&(parse_line(&1, transform))  )
    |> List.flatten()
    |> Enum.reduce(%Array2d{width: w, height: h}, fn {c, r, val}, d -> %Array2d{d | nodes: Map.put(d.nodes, {c, r}, {c, r, val})} end )
  end

  defp parse_line({str, row}, transform) do
    vals = String.split(str, "", trim: true) |> Enum.with_index()
    for {v, col} <- vals do
      {col, row, transform.(v)}
    end
  end

  def neighbors(d, {c, r, _}), do: neighbors(d, {c, r})
  def neighbors(%Array2d{nodes: nodes}, {c, r}) do
    for new_c <- c-1..c+1, new_r <- r-1..r+1, {new_c, new_r} != {c, r} do
      Map.get(nodes, {new_c, new_r}, {new_c, new_r, nil})
    end
    |> Enum.reject(fn {_, _, v} -> v == nil end)
  end

  def cardinal_neighbors(d, {c, r, _}), do: cardinal_neighbors(d, {c, r})
  def cardinal_neighbors(%Array2d{nodes: nodes}, {c, r}) do
    for {c_off, r_off} <- [{0, -1}, {0, 1}, {-1, 0}, {1, 0}] do
      Map.get(nodes, {c+c_off, r+r_off}, {c+c_off, r+r_off, nil})
    end
    |> Enum.reject(fn {_, _, v} -> v == nil end)
  end

  def put(d = %Array2d{nodes: nodes}, {c, r}, val) do
    %Array2d{d |nodes: Map.put(nodes, {c, r}, {c, r, val})}
  end

  def value(%Array2d{nodes: nodes}, loc = {c, r}, default \\ nil) do
    Map.get(nodes, loc, {c, r, default})
  end

  def values(%Array2d{nodes: nodes}), do: Map.values(nodes)

  def valid?(%Array2d{width: w, height: h}, {c, r}) do
    c >= 0 and c < w and r >= 0 and r < h
  end

  def find(%Array2d{nodes: nodes}, val) do
    Map.values(nodes)
    |> Enum.filter(fn {_, _, v} -> v == val end)
  end

  def transform_nodes(arr = %Array2d{nodes: nodes}, transform) do
    new_map = Map.values(nodes)
    |> Enum.reduce(Map.new(), fn {c, r, v}, m -> Map.put(m, {c, r}, {c, r, transform.(v)}) end)
    %Array2d{arr | nodes: new_map}
  end
end
