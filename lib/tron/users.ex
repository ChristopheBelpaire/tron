defmodule Tron.Users do
  use GenServer

  def start_link(opts \\ []) do
    IO.puts('Start users')
    {:ok, _pid} = GenServer.start_link(__MODULE__, 0,name: :users)
  end

  def init(_) do
    {:ok, {0, %{}}}
  end

  def handle_call({:add_user, token }, _from, {nbr_users, users_list}) do
    users_list = Dict.put(users_list, token, "")
    {:reply, nbr_users+1, {nbr_users + 1, users_list}}
  end

  def handle_call({:delete_user, token }, _from, {nbr_users, users_list}) do
    users_list = Dict.delete(users_list, token)
    {:reply, nbr_users-1, {nbr_users - 1, users_list}}
  end

  def handle_call({:set_username, token, name }, _from, {nbr_users, users_list}) do
    users_list = Map.put(users_list, token, name)
    {:reply, name, {nbr_users, users_list}}
  end

  def handle_call(:get_list_users, _from, users_list) do
    {:reply, users_list, users_list}
  end

  def add_user(token) do
    GenServer.call(:users, {:add_user, token})
  end

  def delete_user(token) do
    GenServer.call(:users, {:delete_user, token})
  end

  def set_username(token, name) do
    GenServer.call(:users, {:set_username, token, name})
  end

  def get_users_list() do
    GenServer.call(:users, :get_list_users)
  end
end
