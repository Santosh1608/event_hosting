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
  %Event.Auth.Role{} |> Event.Auth.Role.changeset(%{name: "Admin"}) |> Event.Repo.insert!()

# CREATE ADMIN

username = Keyword.get(Application.get_env(:event, :admin), :username)
email = Keyword.get(Application.get_env(:event, :admin), :email)
password = Keyword.get(Application.get_env(:event, :admin), :password)

admin =
  admin_role
  |> Event.Repo.preload(:users)
  |> Ecto.Changeset.change()
  |> Ecto.Changeset.put_assoc(:users, [
    %Event.Auth.User{}
    |> Event.Auth.User.changeset(%{username: username, email: email, password: password})
  ])
  |> Event.Repo.update!()

IO.inspect("Admin Created")
IO.inspect(admin)
