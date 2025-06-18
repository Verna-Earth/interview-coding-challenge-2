defmodule Verna.Repo.Migrations.CreateGardens do
  use Ecto.Migration

  def change do
    create table(:gardens) do
      timestamps(type: :utc_datetime)
    end
  end
end
