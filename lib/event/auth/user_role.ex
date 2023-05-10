defmodule Event.Auth.UserRole do
  use Ecto.Schema
  alias Event.Auth.User
  alias Event.Auth.Role

  schema "user_roles" do
    belongs_to :users, User, foreign_key: :user_id
    belongs_to :roles, Role, foreign_key: :role_id

    timestamps()
  end
end
