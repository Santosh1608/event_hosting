defmodule Event.Booking.Booking do
  use Ecto.Schema
  alias Event.Auth.User
  alias Event.Event.Event

  @derive {Jason.Encoder, only: [:event, :id]}

  schema "bookings" do
    belongs_to :user, User, foreign_key: :user_id
    belongs_to :event, Event, foreign_key: :event_id

    timestamps()
  end
end
