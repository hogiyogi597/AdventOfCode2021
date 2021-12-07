defmodule Day7.Part2.Main do
  @moduledoc """
  https://adventofcode.com/2021/day/7
  Result: 96086265
  """

  def run(filename) do
    initial_positions = File.read!(filename)
    |> String.split([ "\n", "," ], trim: true)
    |> Enum.map(&String.to_integer/1)

    min = Enum.min(initial_positions)
    max = Enum.max(initial_positions)

    min..max
    |> Enum.map(& calculate_fuel_cost(&1, initial_positions))
    |> Enum.min()
  end

  defp calculate_fuel_cost(target, positions), do: positions |> Enum.reduce(0, & acc_fuel_cost(&1, &2, target))

  defp acc_fuel_cost(pos, acc, target), do: acc + Enum.sum(0..abs(pos - target))
end

result = System.argv() |> Day7.Part2.Main.run()
IO.puts(result)
