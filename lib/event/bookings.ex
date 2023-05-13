defmodule Event.Bookings do
  alias Event.Repo
  import Ecto.Query

  def create_booking(user, event) do
    event
    |> Repo.preload(:users)
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_assoc(:users, [user])
    |> Repo.update()
  end

  def get_bookings(user_id) do
    query =
      from booking in Event.Booking.Booking,
        join: event in assoc(booking, :event),
        where: booking.user_id == ^user_id,
        preload: [event: event]

    Repo.all(query)
  end

  def get_booking(booking_id) do
    Repo.get(Event.Booking.Booking, booking_id)
  end

  def cancel_booking(booking) do
    Event.Booking.Booking.changeset(booking, %{status: "CANCELLED"})
    |> Repo.update()
  end
end
