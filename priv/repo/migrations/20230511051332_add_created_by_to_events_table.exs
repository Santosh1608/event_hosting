defmodule Event.Repo.Migrations.AddCreatedByToEventsTable do
  use Ecto.Migration

  def change do
    alter table(:events) do
      add(:hosted_by, references(:users))
    end
  end
end
