defmodule Event.Repo.Migrations.AddPriceToEventTable do
  use Ecto.Migration

  def change do
    alter table(:events) do
      add :price, :integer, null: false, default: 100
    end
  end
end
