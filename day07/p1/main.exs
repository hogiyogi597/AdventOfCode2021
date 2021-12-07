defmodule Day7.Part1.Main do
  @moduledoc """
  https://adventofcode.com/2021/day/7
  Result: 343468
  """

  def run(filename) do
    initial_positions = File.read!(filename)
    |> String.split([ "\n", "," ], trim: true)
    |> Enum.map(&String.to_integer/1)

    max = Enum.max(initial_positions)
    min = Enum.min(initial_positions)

    min..max
    |> Enum.map(& calculate_fuel_cost(&1, initial_positions))
    |> Enum.min()
  end

  defp calculate_fuel_cost(target, positions) do
    positions
    |> Enum.reduce(0, fn pos, acc -> acc + abs(pos - target) end)
  end
end

result = System.argv() |> Day7.Part1.Main.run()
IO.puts(result)
