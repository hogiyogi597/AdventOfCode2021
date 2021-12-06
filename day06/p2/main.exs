defmodule Day6.Part2.Main do
  @moduledoc """
  https://adventofcode.com/2021/day/6
  Result: 1639643057051
  """

  def run(filename) do
    initial_fish = File.read!(filename)
    |> String.split([ "\n", "," ], trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Enum.reduce(%{}, &add_fish_to_map/2)

    process_fish(initial_fish, 256)
  end

  defp process_fish(fishes, 0), do: fishes |> Enum.reduce(0, fn {_, v}, acc -> acc + v end)

  defp process_fish(fishes, day_count) do
    new_fishes = fishes
    |> Enum.reduce(%{}, fn
      {0, num_fish}, new_fishes ->
        Map.merge(new_fishes, %{6 => num_fish, 8 => num_fish, 0 => 0}, &add_fish/3)
      {cycle, num_fish}, new_fishes ->
        Map.merge(new_fishes, %{cycle - 1 => num_fish, cycle => 0}, &add_fish/3)
    end)

    process_fish(new_fishes, day_count - 1)
  end

  defp add_fish(_k, v1, v2), do: v1 + v2

  defp add_fish_to_map(fish, map), do: Map.merge(map, %{ fish => 1 }, &add_fish/3)
end

result = System.argv() |> Day6.Part2.Main.run()
IO.puts(result)
