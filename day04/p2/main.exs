defmodule Day4.Part1.Main do
  @moduledoc """
  https://adventofcode.com/2021/day/4
  Result: 18063
  """

  def run(filename) do
    [steps | boards] = read_input(filename)

    chunked_boards = boards
    |> Enum.chunk_every(5, 5, :discard)
    |> Enum.map(&combine_board/1)

    steps
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
    |> Enum.reduce_while(chunked_boards, &process_step_on_boards/2)
  end

  defp process_step_on_boards(step, [final_board | []]) do
    new_board = mark_step(final_board, step)
    case bingo?(new_board) do
      true -> {:halt, calc_board_score(new_board, step)}
      false -> {:cont, [new_board]}
    end
  end

  defp process_step_on_boards(step, boards) do
    new_boards = boards |> Enum.map(&(mark_step(&1, step)))

    new_boards
    |> Enum.filter(fn board -> !(bingo?(board)) end)
    |> handle_remaining_boards(step)
  end

  defp handle_remaining_boards(remaining_boards, _step), do: {:cont, remaining_boards}

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

  defp calc_board_score(board, step) do
    (board
    |> Enum.reduce(0, fn
      nil, score -> score
      num, score -> score + num
    end)) * step
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
