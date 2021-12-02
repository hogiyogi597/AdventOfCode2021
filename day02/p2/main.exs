defmodule Day2.Part1.Main do
  @moduledoc """
  https://adventofcode.com/2021/day/2
  Result: 1954293920
  """

  def run(filename) do
    File.stream!(filename)
    |> Stream.map(&clean_input/1)
    |> Enum.to_list
    |> Enum.reduce([0, 0, 0], &chart_course/2)
    |> calc_pos()
  end

  defp chart_course(%{direction: "forward", value: value}, [h, d, a]), do: [h + value, d + a * value, a]
  defp chart_course(%{direction: "down", value: value}, [h, d, a]), do: [h, d, a + value]
  defp chart_course(%{direction: "up", value: value}, [h, d, a]), do: [h, d, a - value]

  defp calc_pos([h, d, _]), do: h * d

  defp clean_input(raw_input) do
    case raw_input
    |> String.trim_trailing()
    |> String.split(" ") do
      [direction | [raw_value | []]] ->
        %{direction: direction, value: String.to_integer(raw_value)}
      _ -> %{}
    end
  end
end

result = System.argv() |> Day2.Part1.Main.run()
IO.puts(result)
