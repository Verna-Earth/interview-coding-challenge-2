defmodule VernaWeb.BedJSON do
  alias Verna.Planting.Bed

  @doc """
  Renders a list of beds.
  """
  def index(%{beds: beds}) do
    %{data: for(bed <- beds, do: data(bed))}
  end

  @doc """
  Renders a single bed.
  """
  def show(%{bed: bed}) do
    %{data: data(bed)}
  end

  defp data(%Bed{} = bed) do
    %{
      id: bed.id,
      x: bed.x,
      y: bed.y,
      width: bed.width,
      length: bed.length,
      soil_type: bed.soil_type,
      garden_id: bed.garden_id
    }
  end
end
