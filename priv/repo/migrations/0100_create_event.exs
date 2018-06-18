defmodule Alastair.Repo.Migrations.CreateEvent do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :name, :string
      add :shop_id, references(:shops, on_delete: :nilify_all)
    end
    create index(:events, [:shop_id])
  end
end
