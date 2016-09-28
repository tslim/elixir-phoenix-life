defmodule GameOfLife.Web.GameController do
  use GameOfLife.Web.Web, :controller

  def index(conn, %{ "cols" => cols, "rows" => rows }) do
    conn
    |> assign(:cols, cols)
    |> assign(:rows, rows)
    |> render("index.html")
  end

  def index(conn, _params) do
    index(conn, %{ "cols" => 30, "rows" => 30 })
  end

end
