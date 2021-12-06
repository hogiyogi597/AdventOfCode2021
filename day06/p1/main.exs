defmodule Day6.Part1.Main do
  @moduledoc """
  https://adventofcode.com/2021/day/6
  Result: 362346
  """

  def run(filename) do
    initial_fish = File.read!(filename)
    |> String.split([ "\n", "," ], trim: true)
    |> Enum.map(&String.to_integer/1)

    Enum.reduce(1..80, initial_fish, fn _, fishes ->
      fishes
      |> process_fishes()
    end)
    |> Enum.count()
  end

  defp process_fishes(initial_fishes, school \\ [])
  defp process_fishes([], school), do: school

  defp process_fishes([0 | rest], school) do
    process_fishes(rest, [6, 8 | school])
  end

  defp process_fishes([fish | rest], school) do
    process_fishes(rest, [fish - 1 | school])
  end
end

result = System.argv() |> Day6.Part1.Main.run()
IO.puts(result)
