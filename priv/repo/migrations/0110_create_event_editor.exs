defmodule Alastair.Repo.Migrations.CreateEventEditor do
  use Ecto.Migration

  def change do
    create table(:event_editors) do
      add :event_id, references(:events, on_delete: :delete_all)
      add :user_id, :string
    end

  end
end
