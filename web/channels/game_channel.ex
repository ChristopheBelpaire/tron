defmodule Tron.GameChannel do
  use Phoenix.Channel
  intercept ["change_direction"]

  def join("rooms:lobby", auth_msg, socket) do
    {:ok, socket}
  end

  def join("rooms:" <> _private_room_id, _auth_msg, socket) do
    {:error, %{reason: "unauthorized"}}
  end

  def handle_in("change_direction", %{"body" => body}, socket) do
    broadcast! socket, "change_direction", %{body: body, user: socket.assigns.user}
    {:noreply, socket}
  end

  def handle_out("change_direction", payload, socket) do
    push socket, "change_direction", payload
    {:noreply, socket}
  end
end
