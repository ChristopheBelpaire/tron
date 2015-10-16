defmodule Tron.RegisterChannel do
  use Phoenix.Channel
  intercept ["register", "register_usccessfull"]

  def join("register:player", auth_msg, socket) do
    {:ok, socket}
  end

  def join("rooms:" <> _private_room_id, _auth_msg, socket) do
    {:error, %{reason: "unauthorized"}}
  end

  def terminate(reason, socket) do
    Tron.Users.delete_user(socket.assigns[:token])
    broadcast! socket, "user_deleted", %{token: socket.assigns[:token], name: socket.assigns[:name] }
    {:noreply, socket}
  end

  def handle_in("register", %{"body" => name}, socket) do
    token = socket.assigns[:token]
    socket = assign(socket, :name, name)
    IO.inspect(token)
    IO.inspect(name)

    Tron.Users.set_username(token, name)
    broadcast! socket, "register", %{name: name, token: token}
    {:noreply, socket}
  end

  def handle_out("register", payload, socket) do

    if socket.assigns[:token] == payload[:token] do
      IO.inspect(socket)
      push socket, "register_successfull", payload
    else
      push socket, "new_user", payload
    end
    {:noreply, socket}
  end
end
