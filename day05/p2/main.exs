defmodule Day5.Part2.Main do
  @moduledoc """
  https://adventofcode.com/2021/day/5
  Result: 21038
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

    cond do
      x1 == x2 || y1 == y2 ->
        for x <- x1..x2, y <- y1..y2, x1 == x2 || y1 == y2, do: %{"#{x},#{y}" => 1}
      true ->
        get_diagonal({x1, y1}, {x2, y2})
    end

  end

  defp get_diagonal(start, fin, points \\ [])

  defp get_diagonal({x1, y1}, {x1, y1}, points), do: [ %{ point_to_string(x1, y1) => 1 } | points]

  defp get_diagonal({x1, y1}, {x2, y2} = fin, points) do
    x_mod = if x1 > x2 do -1 else 1 end
    y_mod = if y1 > y2 do -1 else 1 end

    get_diagonal(
      {x1 + x_mod, y1 + y_mod},
      fin,
      [ %{ point_to_string(x1, y1) => 1 } | points ]
    )
  end

  defp convert_to_point(coords) do
    coords
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
  end

  defp point_to_string(x, y), do: "#{x},#{y}"
end

result = System.argv() |> Day5.Part2.Main.run()
IO.puts(result)
