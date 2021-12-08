defmodule Day8.Part1.Main do
  @moduledoc """
  https://adventofcode.com/2021/day/8
  Result: 534
  """

  def run(filename) do
    File.read!(filename)
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> String.split([",", " ", "|"], trim: true)
      |> Enum.slice(-4, 4)
      |> Enum.reduce(0, fn
        segment, acc ->
          case String.length(segment) do
              2 -> acc + 1
              3 -> acc + 1
              4 -> acc + 1
              7 -> acc + 1
              _ -> acc
            end
        end)
    end)
    |> Enum.sum()
  end
end

result = System.argv() |> Day8.Part1.Main.run()
IO.puts(result)
