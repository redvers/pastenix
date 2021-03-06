defmodule Pastenix.Router do
  use Phoenix.Router

  pipeline :browser do
    plug :accepts, ~w(html)
    plug :fetch_session
  end

  pipeline :api do
    plug :accepts, ~w(json)
  end

  scope "/", Pastenix do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/paste", Pastenix.Controller do
    get  "/",    Paste, :index
    post "/",    Paste, :create
    get  "/:id", Paste, :fetch
    post  "/:id", Paste,:edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", Pastenix do
  #   pipe_through :api
  # end
end
