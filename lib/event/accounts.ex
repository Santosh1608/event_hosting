defmodule Event.Accounts do
  alias Event.Repo
  alias Event.Auth.User
  @admin "Admin"
  def register(params) do
    User.changeset(%User{}, params)
    |> Repo.insert()
  end

  def get_user_by_username(username) do
    Repo.get_by(User, username: username)
  end

  def get_user_by_email(email) do
    Repo.get_by(User, email: email)
  end

  def get_user_by_id(id) do
    Repo.get(User,id)
  end

  def get_user(username) do
    if String.contains?(username, "@") do
      get_user_by_email(username)
    else
      get_user_by_username(username)
    end
  end

  def is_admin?(user) do
    user = user
    |> Repo.preload(:roles)

    !!Enum.find(user.roles,fn role -> role.name === @admin end)
  end
end
