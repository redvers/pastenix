defmodule Pastenix.PageController do
  use Phoenix.Controller

  plug :action

  def index(conn, _params) do
    redirect conn, to: "/paste/"
  end
end
