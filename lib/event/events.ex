defmodule Event.Events do
  alias Event.Repo

  def create_event(admin, event \\ %{}) do
    admin |> Ecto.build_assoc(:event) |> Event.Event.Event.changeset(event) |> Repo.insert()
  end
end
