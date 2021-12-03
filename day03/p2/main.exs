defmodule Day3.Part2.Main do
  @moduledoc """
  https://adventofcode.com/2021/day/3
  Result: 2795310
  """

  def run(filename) do
    File.stream!(filename)
    |> Stream.map(&group_with_index/1)
    |> Enum.to_list
    |> calc_gas_ratings()
    |> calc_life_support_rating()
  end

  defp calc_life_support_rating(ratings) do
    ratings
    |> Enum.map(fn rating ->
      Map.values(rating)
      |> Enum.join("")
      |> Integer.parse(2)
      |> elem(0)
    end)
    |> Enum.reduce(1, &(&1 * &2))
  end

  defp calc_gas_ratings(inputs) do
    [head | _tail] = inputs
    stop_index = map_size(head)

    o2 = inner(inputs, :o2, 0, stop_index)
    co2 = inner(inputs, :co2, 0, stop_index)

    [o2, co2]
  end

  defp inner([head | []], _type, _index, _stop_index) do
    head
  end

  defp inner(_inputs, _type, index, stop_index) when index == stop_index do
    IO.puts("Error... reached end without finding anything")
  end

  defp inner(inputs, type, index, stop_index) do
    target = find_most_common_number(inputs, index, type)

    inputs
    |> Enum.reduce([], fn
      %{^index => bit} = row, acc when bit == target ->
        [ row | acc ]
      _, acc -> acc
    end)
    |> inner(type, index + 1, stop_index)
  end

  defp find_most_common_number(inputs, index, type, count \\ 0, total \\ 0)
  defp find_most_common_number([], _index, type, count, total) do
    case type do
      :o2 ->
        if count >= total / 2 do 1 else 0 end
      :co2 ->
        if count < total / 2 do 1 else 0 end
    end
  end

  defp find_most_common_number([head | tail], index, type, count, total) do
    find_most_common_number(tail, index, type, count + head[index], total + 1)
  end

  defp group_with_index(input) do
    input
    |> String.trim_trailing()
    |> String.graphemes()
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn {bit, pos}, acc ->
      Map.merge(acc, %{pos => String.to_integer(bit)}, fn _k, v1, v2 -> v1 + v2 end)
    end)
  end
end

result = System.argv() |> Day3.Part2.Main.run()
IO.puts(result)
