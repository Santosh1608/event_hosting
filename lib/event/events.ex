defmodule Event.Events do
  alias Event.Repo

  def create_event(admin, event \\ %{}) do
    admin |> Ecto.build_assoc(:event) |> Event.Event.Event.changeset(event) |> Repo.insert()
  end

  def get_event(event_id) do
    Repo.get(Event.Event.Event, event_id)
  end

  def show() do
    Repo.all(Event.Event.Event)
  end
end
