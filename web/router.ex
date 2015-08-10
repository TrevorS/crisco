defmodule Crisco.Router do
  use Crisco.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug UserInfo
  end

  scope "/", Crisco do
    pipe_through :browser

    get "/", LinkController, :new
    post "/", LinkController, :create
    get "/*token", LinkController, :show
  end
end
