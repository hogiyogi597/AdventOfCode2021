defmodule Day5.Part1.Main do
  @moduledoc """
  https://adventofcode.com/2021/day/4
  Result: 7297
  """

  def run(filename) do
    File.stream!(filename)
    |> Stream.map(&String.trim_trailing/1)
    |> Enum.to_list
    |> Enum.map(&split_input/1)
    |> List.flatten()
    |> Enum.reduce(%{}, &(Map.merge(&1, &2, fn _k, v1, v2 -> v1 + v2 end)))
    |> IO.inspect()
    |> Enum.reduce(0, fn
      {_point, total}, acc when total > 1 ->  acc + 1
      _, acc -> acc
    end)
  end

  defp split_input(input) do
    input
    |> String.split(" -> ")
    |> expand_to_points()
  end

  defp expand_to_points([start | [fin | []]]) do
    [x1, y1] = convert_to_point(start)
    [x2, y2] = convert_to_point(fin)

    for x <- x1..x2, y <- y1..y2, x1 == x2 || y1 == y2, do: %{"#{x},#{y}" => 1}
  end

  defp convert_to_point(coords) do
    coords
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
  end
end

result = System.argv() |> Day5.Part1.Main.run()
IO.puts(result)
