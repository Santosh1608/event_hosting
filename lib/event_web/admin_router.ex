defmodule EventWeb.AdminRouter do
  use EventWeb, :router

  pipeline :is_admin do
    plug EventWeb.Plugs.IsAdmin
  end

  scope "/api/admin" do
    pipe_through :is_admin
    scope "/event", EventWeb do
      post "/new", EventController, :new
    end
  end
end
