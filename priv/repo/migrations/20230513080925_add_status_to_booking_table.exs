defmodule Event.Repo.Migrations.AddStatusToBookingTable do
  use Ecto.Migration

  def change do
    alter table(:bookings) do
      add :status, :string, null: false, default: "BOOKED"
    end
  end
end
