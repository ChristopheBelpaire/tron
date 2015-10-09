defmodule Tron.Router do
  use Tron.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :put_user_token
  end

  defp put_user_token(conn, _) do
    token = Phoenix.Token.sign(conn, "user socket", 1)
    user_id = Tron.Users.add_user(token)

    assign(conn, :user_token, token)
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Tron do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", Tron do
  #   pipe_through :api
  # end
end
