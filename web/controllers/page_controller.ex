defmodule Tron.PageController do
  use Tron.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
