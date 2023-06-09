defmodule Event.Event.Event do
  alias Event.Auth.User
  alias Event.Booking.Booking
  import Ecto.Changeset

  use Ecto.Schema

  @derive {Jason.Encoder, only: [:description, :type, :date, :duration, :price, :id]}

  schema "events" do
    field :description, :string
    field :type, :string
    field :date, :date
    field :duration, :integer
    field :price, :integer
    belongs_to :user, User, foreign_key: :hosted_by
    many_to_many(:users, User, join_through: Booking, on_replace: :delete)
    timestamps()
  end

  def changeset(event, attrs) do
    event
    |> cast(attrs, [:description, :type, :date, :duration, :hosted_by, :price])
    |> validate_required([:description, :type, :date, :duration, :hosted_by, :price])
    |> foreign_key_constraint(:hosted_by)
  end
end
