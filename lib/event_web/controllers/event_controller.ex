defmodule EventWeb.EventController do
  use EventWeb, :controller
  action_fallback EventWeb.FallbackController

  def new(conn, params) do
    case Event.Events.create_event(conn.assigns.user, params) do
      {:ok, event} ->
        render(conn, :event, %{result: event})

      {:error, changeset} = error ->
        IO.inspect(changeset)
        error
    end
  end

  def all_events(conn, _params) do
    events = Event.Events.show()
    render(conn, :show, %{result: events})
  end
end
