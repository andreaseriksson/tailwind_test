defmodule TailwindTestWeb.PageController do
  use TailwindTestWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
