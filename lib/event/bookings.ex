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
        join: user in assoc(booking, :user),
        where: user.id == ^user_id,
        preload: [event: event]

    Repo.all(query)
  end
end
