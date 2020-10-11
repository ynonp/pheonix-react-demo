defmodule HelloWeb.HelloController do
  use HelloWeb, :controller
  import PhoenixGon.Controller

  def index(conn, _params) do
    messages = Hello.Message |> Hello.Repo.all |> Enum.map(&(Map.take(&1, [:text, :id])))
    conn = put_gon(conn, messages: messages)
    render(conn, "index.html")
  end
end
