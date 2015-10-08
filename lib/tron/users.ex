defmodule Tron.Users do
  use GenServer

  def start_link(opts \\ []) do
    IO.puts('Start users')
    {:ok, _pid} = GenServer.start_link(__MODULE__, 0,name: :users)
  end

  def init(_) do
    {:ok, []}
  end

  def handle_cast({:add_user, name}, users_list) do
    {:noreply, [name| users_list]}
  end

  def handle_call(:get_list_users, _from, users_list) do
    {:reply, users_list, users_list}
  end

  def add_user(name) do
    GenServer.cast(:users, {:add_user, name})
  end

  def get_users_list() do
    GenServer.call(:users, :get_list_users)
  end
end
