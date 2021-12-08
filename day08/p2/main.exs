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

    keys = get_keys(inputs)

    outputs
    |> create_map_sets()
    |> Enum.map(fn set -> keys |> Enum.find_index(& &1 == set) end)
    |> Enum.join()
    |> String.to_integer()
  end

  defp get_keys(inputs) do
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
      |> Enum.find(& subset?(seven, &1))

    middle_segment =
      three
      |> intersection(four)
      |> difference(one)

    left_top_segment =
      four
      |> difference(three)

    five =
      sets
      |> get_list(5)
      |> Enum.find(& subset?(left_top_segment, &1))

    two =
      sets
      |> get_list(5)
      |> Enum.find(fn
        set when set == three -> false
        set when set == five -> false
        _set -> true
      end)

    nine =
      sets
      |> get_list(6)
      |> Enum.find(& subset?(three, &1))

    zero =
      sets
      |> get_list(6)
      |> Enum.find(fn set -> union(set, middle_segment) == eight end)

    six =
      sets
      |> get_list(6)
      |> Enum.find(fn
        set when set == nine -> false
        set when set == zero -> false
        _set -> true
      end)

    [zero, one, two, three, four, five, six, seven, eight, nine]
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
