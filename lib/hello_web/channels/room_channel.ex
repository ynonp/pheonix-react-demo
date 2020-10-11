defmodule HelloWeb.RoomChannel do
  use Phoenix.Channel

  def join("room:lobby", _message, socket) do
    {:ok, socket}
  end

  def handle_in("new_msg", %{"body" => body}, socket) do
    {:ok, msg } = %Hello.Message{text: body} |> Hello.Repo.insert
    broadcast!(socket, "new_msg", %{body: msg})
    {:noreply, socket}
  end
end
