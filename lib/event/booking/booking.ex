defmodule Event.Booking.Booking do
  use Ecto.Schema
  alias Event.Auth.User
  alias Event.Event.Event
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:event, :id, :inserted_at]}

  schema "bookings" do
    belongs_to :user, User, foreign_key: :user_id
    belongs_to :event, Event, foreign_key: :event_id
    field :status

    timestamps()
  end

  def changeset(booking, attrs \\ %{}) do
    booking
    |> cast(attrs, [:status, :event_id, :user_id])
    |> validate_required([:status, :event_id, :user_id])
    |> foreign_key_constraint(:user_id)
    |> foreign_key_constraint(:event_id)
  end
end
