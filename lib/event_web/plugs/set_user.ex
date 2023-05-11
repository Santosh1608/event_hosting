defmodule EventWeb.Plugs.SetUser do
  import Plug.Conn
  def init(_params) do
    Joken.Signer.create("HS256",Application.get_env(:event,:auth_secret))
  end

  def call(conn,signer) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
        {:ok,data} <- Event.Token.verify(token,signer) do
          conn
          |> assign(:user,Event.Accounts.get_user_by_id(data["user_id"]))
        else
          _error ->
            conn
            |> assign(:user,nil)
        end
  end
end
