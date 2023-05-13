defmodule EventWeb.BookingController do
  use EventWeb, :controller

  action_fallback EventWeb.FallbackController

  plug :set_event when action in [:book_event]
  plug :set_booking when action in [:cancel_booking]
  plug :is_authorized when action in [:cancel_booking]
  plug :is_past_booking? when action in [:book_event]

  def set_event(%{params: %{"id" => event_id}} = conn, _params) do
    case Event.Events.get_event(event_id) do
      nil -> put_view(conn, json: EventWeb.ErrorJSON) |> render(:"404") |> halt()
      event -> assign(conn, :event, event)
    end
  end

  def set_booking(%{params: %{"id" => booking_id}} = conn, _params) do
    case Event.Bookings.get_booking(booking_id) do
      nil -> put_view(conn, json: EventWeb.ErrorJSON) |> render(:"404") |> halt()
      booking -> assign(conn, :booking, booking)
    end
  end

  def book_event(conn, _params) do
    case Event.Bookings.create_booking(conn.assigns.user, conn.assigns.event) do
      {:ok, struct} ->
        render(conn, :book_event, %{result: struct})

      {:error, changeset} = error ->
        IO.inspect(changeset)
        error
    end
  end

  def cancel_booking(conn, _params) do
    case Event.Bookings.cancel_booking(conn.assigns.booking) do
      {:ok, booking} ->
        render(conn, :cancel_booking, %{result: booking})

      {:error, changeset} = error ->
        IO.inspect(changeset)
        error
    end
  end

  def get_bookings(conn, _params) do
    bookings = Event.Bookings.get_bookings(conn.assigns.user.id)
    render(conn, :bookings, %{result: bookings})
  end

  def is_past_booking?(%{assigns: %{event: event}} = conn, _params) do
    if Timex.before?(event.date, Date.utc_today()) do
      conn
      |> put_view(json: EventWeb.ErrorJSON)
      |> render(:"403")
      |> halt()
    else
      conn
    end
  end

  def is_authorized(conn, _params) do
    if conn.assigns.user.id === conn.assigns.booking.user_id do
      conn
    else
      conn
      |> put_view(EventWeb.ErrorJSON)
      |> render(:"401")
      |> halt()
    end
  end
end
