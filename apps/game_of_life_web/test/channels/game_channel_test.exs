defmodule GameOfLife.Web.GameChannelTest do
  use GameOfLife.Web.ChannelCase

  alias GameOfLife.Web.GameChannel

  setup do
    {:ok, _, socket} =
      socket("user_id", %{some: :assign})
      |> subscribe_and_join(GameChannel, "game:update")

    {:ok, socket: socket}
  end

  test "return game state", %{socket: socket} do
    ref = push socket, "game_state", %{"state" => ["2,3","3,3","4,3"], "cols" => "5", "rows" => "5"}
    assert_reply ref, :ok, %{ state: [[3,4],[3,3],[3,2]] }
  end

end
