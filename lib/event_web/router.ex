defmodule EventWeb.Router do
  use EventWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug EventWeb.Plugs.SetUser
  end

  pipeline :is_authenticated do
    plug EventWeb.Plugs.IsAuthenticated
  end

  scope "/api", EventWeb do
    pipe_through :api
    post "/login", AuthController, :login
    post "/register", AuthController, :register
  end

  scope "/api", EventWeb do
    pipe_through [:api, :is_authenticated]
    match(:*, "/admin/*path", AdminRouter, :is_admin)
    get "/me", AuthController, :me
  end

  scope "/api/event", EventWeb do
    pipe_through [:api, :is_authenticated]
    post "/:id/book", BookingController, :book_event
    get "/bookings", BookingController, :get_bookings
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:event, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: EventWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
