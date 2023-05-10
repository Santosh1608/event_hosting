defmodule Event.Repo.Migrations.CreateRoles do
  use Ecto.Migration

  def change do
    create table(:roles) do
      add :name, :string, null: false

      timestamps()
    end

    create unique_index(:roles, [:name])

    current_datetime = NaiveDateTime.utc_now()

    execute "INSERT INTO roles(name, inserted_at, updated_at) VALUES('Admin','#{current_datetime}', '#{current_datetime}')"
  end
end
