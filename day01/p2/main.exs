defmodule Day1.Main do
  @moduledoc """
  https://adventofcode.com/2021/day/1
  Result:
  """

  def run(filename) do
    filename
    |> File.stream!()
    |> Stream.map(fn item ->
      item
      |> String.trim_trailing()
      |> Integer.parse()
      |> elem(0)
    end)
    |> Enum.to_list
    |> Enum.chunk_every(3, 1, :discard)
    |> Enum.map(&Enum.sum/1)
    |> run_rec(0)
  end

  def run_rec(input, count) do
    case input do
      [] -> count
      [_head | []] -> count
      [head | [next_head | tail]] when next_head > head -> run_rec([next_head | tail], count + 1)
      [_head | tail] -> run_rec(tail, count)
    end
  end
end

result = System.argv() |> Day1.Main.run()
IO.puts(result)
