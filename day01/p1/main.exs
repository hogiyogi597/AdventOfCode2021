defmodule Day1.Main do
  def run(filename) do
    input = File.stream!(filename)
    |> Stream.map(fn item ->
      item
      |> String.trim_trailing()
      |> Integer.parse()
      |> elem(0)
    end)
    |> Enum.to_list
    IO.puts("Running against #{Enum.count(input)} inputs")
    run_rec(input, 0)
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
