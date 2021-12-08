defmodule Day8.Part2.Main do
  @moduledoc """
  https://adventofcode.com/2021/day/8
  Result: 1070188
  """

  import MapSet

  def run(filename) do
    File.read!(filename)
    |> String.split("\n", trim: true)
    |> Enum.map(&process_line/1)
    |> Enum.sum()
  end

  defp process_line(line) do
    [inputs, outputs] = String.split(line, ["|"], trim: true)

    sets = inputs
    |> create_map_sets()
    |> Enum.reduce(List.duplicate([], 8), fn set, acc ->
      seg_count = size(set)
      List.update_at(acc, seg_count, & [set | &1])
    end)

    one = sets |> get_elem(2)
    four = sets |> get_elem(4)
    seven = sets |> get_elem(3)
    eight = sets |> get_elem(7)

    three =
      sets
      |> get_list(5)
      |> Enum.find(fn set ->
        intersection(set, seven) == seven
      end)

    middle_segment = intersection(three, four) |> difference(one)
    left_top_segment = difference(four, three)

    five =
      sets
      |> get_list(5)
      |> Enum.find(fn set ->
        size(intersection(left_top_segment, set)) > 0
      end)

    two =
      sets
      |> get_list(5)
      |> Enum.find(fn
        set when set == three -> false
        set when set == five -> false
        _set -> true
      end)

    {[nine | []], rest} =
      sets
      |> get_list(6)
      |> Enum.split_with(fn set ->
        intersection(set, three) == three
      end)

    {[zero | []], [six | []]} =
      rest
      |> Enum.split_with(fn set ->
        difference(set, middle_segment) == set
      end)

    keys = [zero, one, two, three, four, five, six, seven, eight, nine]

    outputs
    |> create_map_sets()
    |> Enum.reduce([], fn set, acc ->
      index = keys
      |> Enum.find_index(& &1 == set)
      [index | acc]
    end)
    |> Enum.join()
    |> String.reverse()
    |> String.to_integer()
  end

  defp create_map_sets(inputs) do
    inputs
    |> String.split([" ", ","], trim: true)
    |> Enum.map(fn number ->
      number
      |> String.graphemes()
      |> MapSet.new()
    end)
  end

  defp get_list(sets, index), do: Enum.at(sets, index)
  defp get_elem(sets, index) do
    [head | _] = Enum.at(sets, index)
    head
  end
end

result = System.argv() |> Day8.Part2.Main.run()
IO.puts(result)
