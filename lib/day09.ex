defmodule Day09 do
  @moduledoc false

  def day() do
    content = File.read!("priv/day09-input.txt")
    |> parseInput()

    p1 = part1(content)
    IO.puts("Part 1: #{p1}")

    p2 = part2(content)
    IO.puts("Part 2: #{p2}")
  end

  def parseInput(input) do
    {_, _, _, files, spaces} = input
    |> String.split("", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Enum.reduce({0, 0, :file, [], []}, &parseNum/2)
    {Enum.sort(files), Enum.sort(spaces)}
  end

  defp parseNum(0, {file_idx, addr_idx, :file, file_acc, space_acc}) do
    {file_idx+1, addr_idx, :space, file_acc, space_acc}
  end
  defp parseNum(num, {file_idx, addr_idx, :file, file_acc, space_acc}) do
    new_files = for idx <- addr_idx..addr_idx+(num-1) do
      {idx, file_idx}
    end
    all_files = [new_files | file_acc] |> List.flatten()
    {file_idx+1, addr_idx+num, :space, all_files, space_acc}
  end
  defp parseNum(0, {file_idx, addr_idx, :space, file_acc, space_acc}) do
    {file_idx, addr_idx, :file, file_acc, space_acc}
  end
  defp parseNum(num, {file_idx, addr_idx, :space, file_acc, space_acc}) do
    new_spaces = Enum.to_list(addr_idx..addr_idx+(num-1))
    all_spaces = [new_spaces | space_acc] |> List.flatten()
    {file_idx, addr_idx+num, :file, file_acc, all_spaces}
  end

  def part1({files, spaces}) do
    defrag(Enum.reverse(files), spaces, [])
    |> Enum.map(&checksum/1)
    |> Enum.sum()
  end

  defp defrag([], _spaces, acc), do: acc |> List.flatten() |> Enum.sort()
  defp defrag(files, [], acc), do: [files | acc] |> List.flatten() |> Enum.sort()
  defp defrag(files = [{file_idx, _file_num} | _files_rest],
              [spaces_first | _spaces_rest],
              acc) when spaces_first >= file_idx,
              do: [files | acc] |> List.flatten() |> Enum.sort()
  defp defrag([{_, file_num} | files_rest], [spaces_first | spaces_rest], acc) do
    defrag(files_rest, spaces_rest, [{spaces_first, file_num} | acc])
  end

  defp checksum({idx, num}), do: idx * num

  def part2({_files, _spaces}) do
    0
  end
end
