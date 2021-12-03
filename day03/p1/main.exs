defmodule Day3.Part1.Main do
  @moduledoc """
  https://adventofcode.com/2021/day/3
  Result: 3148794
  """

  def run(filename) do
    File.stream!(filename)
    |> Stream.map(&group_with_index/1)
    |> Enum.to_list
    |> Enum.reduce(%{count: 0}, fn map, acc ->
      Map.merge(acc, Map.put(map, :count, 1), fn _k, v1, v2 -> v1 + v2 end)
    end)
    |> calc_power_consumption()
  end

  defp calc_power_consumption(map) do
    half = map.count / 2

    map
    |> Map.delete(:count)
    |> Enum.reduce(["", ""], fn
      {_pos, count}, [gamma, epsilon] when count < half ->
        [gamma <> "0", epsilon <> "1"]
      {_pos, _count}, [gamma, epsilon] ->
        [gamma <> "1", epsilon <> "0"]
    end)
    |> Enum.map( fn bin_string ->
      bin_string
      |> Integer.parse(2)
      |> elem(0)
    end)
    |> Enum.reduce(1, &(&1 * &2))
  end

  defp group_with_index(inputs) do
    inputs
    |> String.trim_trailing()
    |> String.graphemes()
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn {bit, pos}, acc ->
      Map.merge(acc, %{pos => String.to_integer(bit)}, fn _k, v1, v2 -> v1 + v2 end)
    end)
  end
end

result = System.argv() |> Day3.Part1.Main.run()
IO.puts(result)
