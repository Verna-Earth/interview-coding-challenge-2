defmodule Verna.PlantingFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Verna.Planting` context.
  """

  @doc """
  Generate a garden.
  """
  def garden_fixture(attrs \\ %{}) do
    {:ok, garden} =
      attrs
      |> Enum.into(%{})
      |> Verna.Planting.create_garden()

    garden
  end

  @doc """
  Generate a bed.
  """
  def bed_fixture(attrs \\ %{}) do
    {:ok, bed} =
      attrs
      |> Enum.into(%{
        garden_id: 42,
        length: 42,
        soil_type: "some soil_type",
        width: 42,
        x: 42,
        y: 42
      })
      |> Verna.Planting.create_bed()

    bed
  end
end
