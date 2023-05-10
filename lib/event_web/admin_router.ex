defmodule EventWeb.AdminRouter do
  use EventWeb, :router

  scope "/api/admin", EventWeb do
    get "/name", AuthController, :login
  end
end
