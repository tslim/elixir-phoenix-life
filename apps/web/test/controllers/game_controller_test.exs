defmodule GameOfLife.Web.GameControllerTest do
  use GameOfLife.Web.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Game of Life"
  end
end
