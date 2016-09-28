defmodule GameOfLife.Web.GameChannel do

  @moduledoc '''
  Web socket channel to handle game updates
  '''

  use Phoenix.Channel
  require Logger

  def join("game:update", _message, socket) do
    {:ok, socket}
  end

  def join("game:" <> _game_id, _params, _socket) do
    {:error, %{reason: "unauthorized"}}
  end

  def handle_in("game_state", %{"state" => state, "cols" => cols, "rows" => rows}, socket) do
    game_state =
      state
      |> convert_to_game_state_format
      |> GameOfLife.tick([cols,rows])

    {:reply, {:ok, %{state: game_state}}, socket}
  end

  def convert_to_game_state_format(state) do
    Enum.map(state, fn(cell) ->
      cell
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)
    end)
  end
end