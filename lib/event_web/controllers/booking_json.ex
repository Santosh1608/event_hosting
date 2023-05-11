defmodule EventWeb.BookingJSON do
  def book_event(%{result: result}) do
    result
  end

  def bookings(%{result: result}) do
    result
  end
end
