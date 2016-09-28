defmodule GameOfLife do
  @moduledoc """
  Handles the logic for Conway's Game of Life.

  Each cell is tracked as a list that represents its coordinate
  E.g. [1, 2] = Column 1, Row 2

  On each iteration of the game, we gather a list of neighbours
  for all active cells. Then we apply the game of logic of each
  of them.

  The state of the next iteration is simply a new list of
  active cells.
  """

  @doc """
  Transform current board state to the next iteration.
  Returns a new list of active cells
  """
  def tick(state, board_size) do
    state
    |> list_of_affected_cells_in_this_iteration(board_size)
    |> apply_game_logic(state, board_size)
  end

  @doc """
  Returns a list of cells that will be affected in this iteration.
  This is basically the neighbours of all currently active cells.
  """
  def list_of_affected_cells_in_this_iteration(state, board_size) do
    state
    |> Enum.flat_map(fn (cell) -> list_of_neighbours(cell, board_size) end)
    |> Enum.uniq
  end

  @doc """
  Returns a list of neighbour for a cell, including itself
  """
  def list_of_neighbours([x,y], board_size) do
    [ [x-1, y+1], [x, y+1], [x+1, y+1],
      [x-1, y],   [x, y],   [x+1, y],
      [x-1, y-1], [x, y-1], [x+1, y-1]
    ]
    |> remove_out_of_bound_cells!(board_size)
  end

  @doc """
  Remove cells that is beyond the current board size
  """
  def remove_out_of_bound_cells!(cells, [cols, rows]) do
    cells
    |> Enum.filter(fn([x,y]) -> x > 0 && y > 0 && x <= cols && y <= rows end )
  end

  @doc """
  Apply Game of Life Logic
  """
  def apply_game_logic(affected_cells, state, board_size) do
    affected_cells
    |> Enum.filter(fn (cell) -> is_cell_populated?(cell, state, board_size) end)
  end

  @doc """
  Determines if a cell should be populated or not
  - If a cell is currently populated and have 2-3 active neighbours, it stays alive
  - If a cell is not currently populated but have 3 active neighbours, it will be populated
  - In all other cases, the cell dies
  """
  def is_cell_populated?(cell, state, board_size) do
    active_neighbours = number_of_active_neighbours(cell, state, board_size)
    cond do
      Enum.member?(state, cell) && active_neighbours in 2..3 ->
        true
      !Enum.member?(state, cell) && active_neighbours == 3 ->
        true
      true ->
        false
    end
  end

  @doc """
  Calculates the number of active neighbours for a cell
  """
  def number_of_active_neighbours(cell, state, board_size) do
    list_of_neighbours(cell, board_size)
    |> Enum.filter(fn (c) -> c != cell && Enum.member?(state, c) end)
    |> length
  end
end
