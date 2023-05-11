defmodule Event.Repo.Migrations.AddBookingTable do
  use Ecto.Migration

  def change do
    create table(:bookings) do
      add :user_id, references(:users, on_delete: :delete_all)
      add :event_id, references(:events, on_delete: :delete_all)

      timestamps()
    end

    create index(:bookings, [:user_id])
    create index(:bookings, [:event_id])
  end
end
