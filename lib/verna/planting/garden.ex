defmodule Verna.Planting.Garden do
  use Ecto.Schema
  import Ecto.Changeset

  schema "gardens" do
    has_many :beds, Verna.Planting.Bed

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(garden, attrs) do
    garden
    |> cast(attrs, [])
    |> validate_required([])
  end
end
