defmodule Event.Repo.Migrations.RemoveHostInEventsTable do
  use Ecto.Migration

  def change do
    alter table(:events) do
      remove :host
    end
  end
end
