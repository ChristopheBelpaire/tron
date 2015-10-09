defmodule Tron.RegisterChannel do
  use Phoenix.Channel
  intercept ["register", "register_usccessfull"]

  def join("register:player", auth_msg, socket) do
    {:ok, socket}
  end

  def join("rooms:" <> _private_room_id, _auth_msg, socket) do
    {:error, %{reason: "unauthorized"}}
  end

  def handle_in("register", %{"body" => name}, %{assigns: %{user: token}}, socket) do
    IO.inspect(socket)
    #Tron.Users.set_username(body, token)
    broadcast! socket, "register", %{body: name}
    {:noreply, socket}
  end

  def handle_out("register", payload, socket) do

    if socket.assigns[:user] == payload[:body] do
      IO.inspect(socket)
      push socket, "register_successfull", payload
    else
      push socket, "new_user", payload
    end
    {:noreply, socket}
  end
end
