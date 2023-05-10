defmodule EventWeb.AuthController do
  use EventWeb, :controller
  alias Event.Accounts
  alias EventWeb.Helpers.Auth
  alias Event.Auth.User
  action_fallback EventWeb.FallbackController
  require Logger

  def login(conn, %{"password" => password, "username" => username}) do
    with %User{} = user <- Accounts.get_user(username),
         true <- Auth.is_authenticated(password, user.password) do
      token = Auth.create_token(user.id)
      Logger.info("Login success")
      render(conn, :login, %{result: %{token: token}})
    else
      _ ->
        Logger.error("Login fail")
        {:error, :unauthorized}
    end
  end

  def register(conn, %{"profile" => profile} = params) do
    Logger.info("Uploading image")
    case Cloudex.upload(profile.path) do
      {:ok,image} ->
        params = Map.put(params,:avatar,image.secure_url)
        register(conn,params)
      {:error, error} -> IO.inspect(error)
    end
  end

  def register(conn, %{"avatar" => avatar = %Plug.Upload{}} = params) do
    case Cloudex.upload(avatar.path) do
      {:ok,image} -> register(conn,%{params | "avatar" => image.secure_url})
      {:error,error} -> IO.inspect(error)
    end
  end

  def register(conn,params) do
    case Accounts.register(params) do
      {:ok, user} ->
        Logger.info("User registration success")
        token = Auth.create_token(user.id)
        render(conn, :register, %{result: %{token: token}})

      {:error, changeset} = error ->
        Logger.error("User registration fail")
        IO.inspect(changeset)
        error
    end
  end

  def me(conn, _params) do
    render(conn, :me, %{result: conn.assigns.user})
  end
end
