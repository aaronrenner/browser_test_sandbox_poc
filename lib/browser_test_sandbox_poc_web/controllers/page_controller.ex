defmodule BrowserTestSandboxPocWeb.PageController do
  use BrowserTestSandboxPocWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
