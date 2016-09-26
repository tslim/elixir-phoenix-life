defmodule GameOfLifeTest do
  use ExUnit.Case, async: true
  doctest GameOfLife

  test "Transform current board state to the next iteration" do
    state = [[1,2], [2,2], [3,2]]
    board_size = [3,3]
    new_state = [[2,3], [2,2], [2,1]]
    assert GameOfLife.tick(state, board_size) == new_state

    state = [[2,2], [2,3]]
    board_size = [3,3]
    assert GameOfLife.tick(state, board_size) == []
  end

  test "Returns a list of cells that will be affected in this iteration" do
    state = [[2,3], [3,2], [4,3], [3,4]]
    board_size = [5,5]
    affected_cells = [ [1, 4], [2, 4], [3, 4],
                        [1, 3], [2, 3], [3, 3],
                        [1, 2], [2, 2], [3, 2],
                        [4, 3], [4, 2], [2, 1],
                        [3, 1], [4, 1], [4, 4],
                        [5, 4], [5, 3], [5, 2],
                        [2, 5], [3, 5], [4, 5] ]
    assert GameOfLife.list_of_affected_cells_in_this_iteration(state, board_size) == affected_cells
  end

  test "List of neighbours include itself" do
    cell = [2,2]
    board_size = [3,3]
    neighbouring_cells = [[1, 3], [2, 3], [3, 3], [1, 2], [2, 2], [3, 2], [1, 1], [2, 1], [3, 1]]
    assert GameOfLife.list_of_neighbours(cell, board_size) == neighbouring_cells
  end

  test "Remove out of bound cells" do
    cells = [[0,1], [1,1], [5,3]]
    board_size = [3,3]
    assert GameOfLife.remove_out_of_bound_cells!(cells, board_size) == [[1,1]]
  end

  test "Apply Game Logic" do
    state = [[2,2]]
    board_size = [3,3]
    affected_cells = [[1,1], [2,1], [3,1],
                      [1,2], [2,2], [3,2],
                      [1,3], [2,3], [3,3]]
    assert GameOfLife.apply_game_logic(affected_cells, state, board_size) == []
  end

  test "Determines if a cell should be populated in next iteration" do
    state = [[1,2], [2,2], [3,2]]
    board_size = [3,3]

    assert GameOfLife.is_cell_populated?([2,2], state, board_size) == true
    assert GameOfLife.is_cell_populated?([2,3], state, board_size) == true
    assert GameOfLife.is_cell_populated?([1,1], state, board_size) == false
  end

  test "Calculate number of active neighbours for a cell" do
    state = [[1,2], [2,2], [3,2]]
    board_size = [3,3]
    assert GameOfLife.number_of_active_neighbours([2,2], state, board_size) == 2
    assert GameOfLife.number_of_active_neighbours([3,2], state, board_size) == 1
    assert GameOfLife.number_of_active_neighbours([1,2], state, board_size) == 1
  end
end
