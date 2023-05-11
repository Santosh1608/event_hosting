defmodule EventWeb.BookingController do
  use EventWeb, :controller

  action_fallback EventWeb.FallbackController

  plug :set_event when action in [:book_event]

  def set_event(%{params: %{"id" => event_id}} = conn, _params) do
    case Event.Events.get_event(event_id) do
      nil -> put_view(conn, EventWeb.ErrorJSON) |> render(:"404") |> halt()
      event -> assign(conn, :event, event)
    end
  end

  def book_event(conn, _params) do
    case Event.Bookings.create_booking(conn.assigns.user, conn.assigns.event) do
      {:ok, struct} ->
        IO.inspect(struct)
        render(conn, :book_event, %{result: struct})

      {:error, changeset} = error ->
        IO.inspect(changeset)
        error
    end
  end

  def get_bookings(conn, _params) do
    IO.inspect(conn.assigns.user)
    bookings = Event.Bookings.get_bookings(conn.assigns.user.id)
    render(conn, :bookings, %{result: bookings})
  end
end
