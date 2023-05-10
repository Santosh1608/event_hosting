defmodule EventWeb.Plugs.SetUser do
  import Plug.Conn
  def init(_params) do
    Joken.Signer.create("HS256",Application.get_env(:event,:auth_secret))
  end

  def call(conn,signer) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
        {:ok,data} <- Event.Token.verify(token,signer) do
          IO.inspect(data)
          conn
          |> assign(:user,Event.Accounts.get_user_by_id(data["user_id"]))
        else
          _error ->
            conn
            |> put_status(:unauthorized)
            |> Phoenix.Controller.put_view(EventWeb.ErrorJSON)
            |> Phoenix.Controller.render(:"401")
            |> halt()
        end
  end
end
