defmodule Event.Repo.Migrations.MakeHostedByRequiredEvents do
  use Ecto.Migration

  def change do
    alter table(:events) do
      modify(:hosted_by, references(:users), null: false, from: references(:users))
    end
  end
end
