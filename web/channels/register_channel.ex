defmodule Tron.RegisterChannel do
  use Phoenix.Channel
  intercept ["register"]

  def join("register:player", auth_msg, socket) do
    {:ok, socket}
  end

  def join("rooms:" <> _private_room_id, _auth_msg, socket) do
    {:error, %{reason: "unauthorized"}}
  end

  def handle_in("register", %{"body" => body}, socket) do
    IO.inspect(body)
    #broadcast! socket, "change_direction", %{body: body, user: socket.assigns.user}
    {:noreply, socket}
  end

  def handle_out("change_direction", payload, socket) do
    push socket, "change_direction", payload
    {:noreply, socket}
  end
end
