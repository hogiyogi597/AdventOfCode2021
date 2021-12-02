defmodule Day2.Part1.Main do
  @moduledoc """
  https://adventofcode.com/2021/day/2
  Result: 1954293920
  """

  def run(filename) do
    File.stream!(filename)
    |> Stream.map(&String.trim_trailing/1)
    |> Enum.to_list
    |> Enum.reduce([0, 0, 0], &chart_course/2)
    |> calc_pos()
  end

  defp chart_course("forward " <> value, [h, d, a]), do: [h + String.to_integer(value), d + a * String.to_integer(value), a]
  defp chart_course("down " <> value, [h, d, a]), do: [h, d, a + String.to_integer(value)]
  defp chart_course("up " <> value, [h, d, a]), do: [h, d, a - String.to_integer(value)]

  defp calc_pos([h, d, _]), do: h * d
end

result = System.argv() |> Day2.Part1.Main.run()
IO.puts(result)
