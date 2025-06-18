defmodule VernaWeb.GardenJSON do
  alias Verna.Planting.Garden

  @doc """
  Renders a list of gardens.
  """
  def index(%{gardens: gardens}) do
    %{data: for(garden <- gardens, do: data(garden))}
  end

  @doc """
  Renders a single garden.
  """
  def show(%{garden: garden}) do
    %{data: data(garden)}
  end

  defp data(%Garden{} = garden) do
    %{
      id: garden.id
    }
  end
end
