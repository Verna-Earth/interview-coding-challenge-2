defmodule Verna.Planting.Plan do
  use Ecto.Schema
  import Ecto.Changeset

  schema "plans" do
    field :name, :string
    field :beds, :map
    belongs_to(:garden, Verna.Planting.Garden)

    timestamps(type: :utc_datetime)
  end

  @required_attrs ~w(name beds garden_id)a

  @doc false
  def changeset(plan, attrs) do
    plan
    |> cast(attrs, @required_attrs)
    |> validate_required(@required_attrs)
  end
end
