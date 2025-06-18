defmodule Verna.Planting.Bed do
  use Ecto.Schema
  import Ecto.Changeset

  schema "beds" do
    field :length, :integer
    field :width, :integer
    field :y, :integer
    field :x, :integer
    field :soil_type, :string

    belongs_to(:garden, Verna.Planting.Garden)
    timestamps(type: :utc_datetime)
  end

  @required_attrs ~w(x y width length soil_type garden_id)a

  @doc false
  def changeset(bed, attrs) do
    bed
    |> cast(attrs, @required_attrs)
    |> validate_required(@required_attrs)
  end
end
