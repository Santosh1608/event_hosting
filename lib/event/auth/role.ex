defmodule Event.Auth.Role do
  use Ecto.Schema
  import Ecto.Changeset
  alias Event.Auth.User
  alias Event.Auth.UserRole

  schema "roles" do
    field :name, :string
    many_to_many(:users, User, join_through: UserRole, on_replace: :delete)

    timestamps()
  end

  def changeset(role, attrs) do
    role
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
