defmodule Day4.Part1.Main do
  @moduledoc """
  https://adventofcode.com/2021/day/4
  Result: 12796
  """

  def run(filename) do
    [steps | boards] = read_input(filename)

    chunked_boards = boards
    |> Enum.chunk_every(5, 5, :discard)
    |> Enum.map(&combine_board/1)

    steps
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
    |> Enum.reduce_while(chunked_boards, &process_step_on_board/2)
  end

  defp process_step_on_board(step, boards) do
    new_boards = boards |> Enum.map(&(mark_step(&1, step)))

    case new_boards |> Enum.find(&bingo?/1) do
      nil ->
        {:cont, new_boards}
      board ->
        {:halt, step * calc_board_score(board)}
    end
  end

  defp mark_step(board, step) do
    board
    |> Enum.map(fn
      ^step -> nil
      num -> num
    end)
  end

  defp bingo?([nil, nil, nil, nil, nil, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _]), do: true
  defp bingo?([_, _, _, _, _, nil, nil, nil, nil, nil, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _]), do: true
  defp bingo?([_, _, _, _, _, _, _, _, _, _, nil, nil, nil, nil, nil, _, _, _, _, _, _, _, _, _, _]), do: true
  defp bingo?([_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, nil, nil, nil, nil, nil, _, _, _, _, _]), do: true
  defp bingo?([_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, nil, nil, nil, nil, nil]), do: true
  defp bingo?([nil, _, _, _, _, nil, _, _, _, _, nil, _, _, _, _, nil, _, _, _, _, nil, _, _, _, _]), do: true
  defp bingo?([_, nil, _, _, _, _, nil, _, _, _, _, nil, _, _, _, _, nil, _, _, _, _, nil, _, _, _]), do: true
  defp bingo?([_, _, nil, _, _, _, _, nil, _, _, _, _, nil, _, _, _, _, nil, _, _, _, _, nil, _, _]), do: true
  defp bingo?([_, _, _, nil, _, _, _, _, nil, _, _, _, _, nil, _, _, _, _, nil, _, _, _, _, nil, _]), do: true
  defp bingo?([_, _, _, _, nil, _, _, _, _, nil, _, _, _, _, nil, _, _, _, _, nil, _, _, _, _, nil]), do: true
  defp bingo?(_board), do: false

  defp calc_board_score(board) do
    board
    |> Enum.reduce(0, fn
      nil, score -> score
      num, score -> score + num
    end)
  end

  defp combine_board(board_arr) do
    board_arr
    |> Enum.join(" ")
    |> String.split(" ")
    |> Enum.filter(&(&1 != ""))
    |> Enum.map(&String.to_integer/1)
  end

  defp read_input(filename) do
    File.stream!(filename)
    |> Stream.map(&String.trim_trailing/1)
    |> Enum.filter(&(&1 != ""))
    |> Enum.to_list
  end
end

result = System.argv() |> Day4.Part1.Main.run()
IO.puts(result)
