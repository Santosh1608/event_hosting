defmodule Event.Repo.Migrations.AddEventsTable do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :description, :string, null: false
      add :type, :string, null: false
      add :date, :date, null: false
      add :duration, :integer
      add :host, references(:users, on_delete: :delete_all)

      timestamps()
    end

  end
end
