defmodule EventWeb.Plugs.IsAuthenticated do
  import Plug.Conn

  def init(_params) do
    # Do nothing
  end

  def call(conn,_params) do
    if conn.assigns.user do
      conn
    else
      conn
            |> put_status(:unauthorized)
            |> Phoenix.Controller.put_view(EventWeb.ErrorJSON)
            |> Phoenix.Controller.render(:"401")
            |> halt()
    end
  end
end
