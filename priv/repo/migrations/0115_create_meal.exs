defmodule Alastair.Repo.Migrations.CreateMeal do
  use Ecto.Migration

  def change do
    create table(:meals) do
      add :name, :string
      add :time, :time
      add :date, :date

      add :event_id, references(:events, on_delete: :delete_all)


      timestamps()
    end

  end
end
