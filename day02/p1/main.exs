defmodule Day2.Part1.Main do
  @moduledoc """
  https://adventofcode.com/2021/day/2
  Result: 1670340
  """

  def run(filename) do
    File.stream!(filename)
    |> Stream.map(&clean_input/1)
    |> Enum.to_list
    |> runner()
  end

  defp runner(inputs, horizontal \\ 0, depth \\ 0) do
    case inputs do
      nil -> horizontal * depth
      [] -> horizontal * depth
      [ %{direction: "forward", value: value} | next_steps] -> runner(next_steps, horizontal + value, depth)
      [ %{direction: "down", value: value} | next_steps] -> runner(next_steps, horizontal, depth + value)
      [ %{direction: "up", value: value} | next_steps] -> runner(next_steps, horizontal, depth - value)
    end
  end

  defp clean_input(raw_input) do
    case raw_input
    |> String.trim_trailing()
    |> String.split(" ") do
      [direction | [raw_value | []]] ->
        value = raw_value |> Integer.parse() |> elem(0)
        %{direction: direction, value: value}
      _ -> %{}
    end
  end
end

result = System.argv() |> Day2.Part1.Main.run()
IO.puts(result)
