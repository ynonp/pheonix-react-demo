defmodule HelloWeb.HelloController do
  use HelloWeb, :controller
  import PhoenixGon.Controller

  plug :put_view, HelloWeb.LayoutView

  def index(conn, _params) do
    messages = Hello.Message |> Hello.Repo.all
    conn = put_gon(conn, messages: messages)
    render(conn, "app.html")
  end
end
