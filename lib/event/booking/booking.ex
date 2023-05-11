defmodule Event.Booking.Booking do
  use Ecto.Schema
  alias Event.Auth.User
  alias Event.Event.Event

  schema "bookings" do
    belongs_to :users, User, foreign_key: :user_id
    belongs_to :events, Event, foreign_key: :event_id

    timestamps()
  end
end
