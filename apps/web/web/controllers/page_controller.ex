defmodule GameOfLife.Web.PageController do
  use GameOfLife.Web.Web, :controller

  def index(conn, %{ cols: cols, rows: rows } = params) do
    conn
    |> assign(:cols, cols)
    |> assign(:rows, rows)
    |> render "index.html"
  end

  def index(conn, _params) do
    index(conn, %{ cols: 50, rows: 50 })
  end

end
