defmodule Verna.Repo.Migrations.CreatePlans do
  use Ecto.Migration

  def change do
    create table(:plans) do
      add :name, :string
      add :beds, :jsonb
      add(:garden_id, references(:gardens, on_delete: :nothing))

      timestamps(type: :utc_datetime)
    end
  end
end
