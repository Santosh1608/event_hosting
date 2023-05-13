defmodule EventWeb.BookingJSON do
  def book_event(%{result: result}) do
    result
  end

  def bookings(%{result: result}) do
    result
  end

  def cancel_booking(%{result: booking}) do
    %{
      id: booking.id,
      status: booking.status
    }
  end
end
