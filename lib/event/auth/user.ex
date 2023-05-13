defmodule Event.Auth.User do
  use Ecto.Schema

  import Ecto.Changeset
  alias Event.Auth.Role
  alias Event.Auth.UserRole

  @derive {Jason.Encoder, only: [:username, :email, :avatar]}

  schema "users" do
    field :username, :string
    field :email, :string
    field :avatar, :string
    field :password, :string
    has_one :event, Event.Event.Event, foreign_key: :hosted_by

    many_to_many(:roles, Role, join_through: UserRole, on_replace: :delete)

    many_to_many(:events, Event.Event.Event,
      join_through: Event.Booking.Booking,
      on_replace: :delete
    )

    timestamps()
  end

  def changeset(user, attrs \\ %{}) do
    user
    |> cast(attrs, [:username, :email, :password, :avatar])
    |> validate_required([:username, :email, :password])
    |> validate_length(:username, min: 2, max: 20)
    |> validate_length(:password, min: 8, max: 30)
    |> unique_constraint(:email)
    |> unique_constraint(:username)
    |> update_change(:email, fn email -> String.downcase(email) end)
    |> update_change(:username, &String.downcase(&1))
    |> hash_password
  end

  defp hash_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :password, Pbkdf2.hash_pwd_salt(password))

      _ ->
        changeset
    end
  end
end
