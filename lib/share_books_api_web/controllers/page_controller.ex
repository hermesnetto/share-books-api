defmodule ShareBooksApiWeb.PageController do
  use ShareBooksApiWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
