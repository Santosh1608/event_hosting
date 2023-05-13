# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Event.Repo.insert!(%Event.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

# CREATE ADMIN ROLE

admin_role =
  %Event.Auth.Role{name: "Admin"} |> Event.Auth.Role.changeset() |> Event.Repo.insert!()

# CREATE ADMIN
admin =
  admin_role
  |> Event.Repo.preload(:users)
  |> Ecto.Changeset.change()
  |> Ecto.Changeset.put_assoc(:users, [
    %{username: "admin", email: "admin@gmail.com", password: "San1234$"}
  ])
  |> Event.Repo.update!()

IO.inspect("Admin Created")
IO.inspect(admin)
