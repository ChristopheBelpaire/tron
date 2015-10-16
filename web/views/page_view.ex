defmodule Tron.PageView do
  use Tron.Web, :view

  def users do
    {_, users} =Tron.Users.get_users_list
    users |> Enum.reject(fn {token, name}-> name=="" end)
  end
end
