defmodule EventWeb.Plugs.IsAdmin do
  import Plug.Conn

  def init(_params) do
    # do nothing
  end

  def call(conn, _params) do
    if Event.Accounts.is_admin?(conn.assigns.user) do
      conn
    else
      conn
      |> Phoenix.Controller.put_view(EventWeb.ErrorJSON)
      |> Phoenix.Controller.render(:"401")
      |> halt()
    end
  end
end
