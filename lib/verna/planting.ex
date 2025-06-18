defmodule Verna.Planting do
  @moduledoc """
  The Planting context.
  """

  import Ecto.Query, warn: false
  alias Verna.Repo

  alias Verna.Planting.Garden

  @doc """
  Returns the list of gardens.

  ## Examples

      iex> list_gardens()
      [%Garden{}, ...]

  """
  def list_gardens do
    Repo.all(Garden)
  end

  @doc """
  Gets a single garden.

  Raises `Ecto.NoResultsError` if the Garden does not exist.

  ## Examples

      iex> get_garden!(123)
      %Garden{}

      iex> get_garden!(456)
      ** (Ecto.NoResultsError)

  """
  def get_garden!(id), do: Repo.get!(Garden, id)

  @doc """
  Creates a garden.

  ## Examples

      iex> create_garden(%{field: value})
      {:ok, %Garden{}}

      iex> create_garden(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_garden(attrs \\ %{}) do
    %Garden{}
    |> Garden.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a garden.

  ## Examples

      iex> update_garden(garden, %{field: new_value})
      {:ok, %Garden{}}

      iex> update_garden(garden, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_garden(%Garden{} = garden, attrs) do
    garden
    |> Garden.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a garden.

  ## Examples

      iex> delete_garden(garden)
      {:ok, %Garden{}}

      iex> delete_garden(garden)
      {:error, %Ecto.Changeset{}}

  """
  def delete_garden(%Garden{} = garden) do
    Repo.delete(garden)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking garden changes.

  ## Examples

      iex> change_garden(garden)
      %Ecto.Changeset{data: %Garden{}}

  """
  def change_garden(%Garden{} = garden, attrs \\ %{}) do
    Garden.changeset(garden, attrs)
  end

  alias Verna.Planting.Bed

  @doc """
  Returns the list of beds.

  ## Examples

      iex> list_beds()
      [%Bed{}, ...]

  """
  def list_beds do
    Repo.all(Bed)
  end

  @doc """
  Gets a single bed.

  Raises `Ecto.NoResultsError` if the Bed does not exist.

  ## Examples

      iex> get_bed!(123)
      %Bed{}

      iex> get_bed!(456)
      ** (Ecto.NoResultsError)

  """
  def get_bed!(id), do: Repo.get!(Bed, id)

  @doc """
  Creates a bed.

  ## Examples

      iex> create_bed(%{field: value})
      {:ok, %Bed{}}

      iex> create_bed(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_bed(attrs \\ %{}) do
    %Bed{}
    |> Bed.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a bed.

  ## Examples

      iex> update_bed(bed, %{field: new_value})
      {:ok, %Bed{}}

      iex> update_bed(bed, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_bed(%Bed{} = bed, attrs) do
    bed
    |> Bed.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a bed.

  ## Examples

      iex> delete_bed(bed)
      {:ok, %Bed{}}

      iex> delete_bed(bed)
      {:error, %Ecto.Changeset{}}

  """
  def delete_bed(%Bed{} = bed) do
    Repo.delete(bed)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking bed changes.

  ## Examples

      iex> change_bed(bed)
      %Ecto.Changeset{data: %Bed{}}

  """
  def change_bed(%Bed{} = bed, attrs \\ %{}) do
    Bed.changeset(bed, attrs)
  end
end
