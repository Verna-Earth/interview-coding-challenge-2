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

  def get_garden_and_beds!(id) do
    query =
      from gardens in Garden,
        where: gardens.id == ^id,
        left_join: beds in assoc(gardens, :beds),
        preload: [beds: beds]

    Repo.one!(query)
  end

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

  alias Verna.Planting.Plan

  @doc """
  Returns the list of plans.

  ## Examples

      iex> list_plans()
      [%Plan{}, ...]

  """
  def list_plans do
    Repo.all(Plan)
  end

  @doc """
  Gets a single plan.

  Raises `Ecto.NoResultsError` if the Plan does not exist.

  ## Examples

      iex> get_plan!(123)
      %Plan{}

      iex> get_plan!(456)
      ** (Ecto.NoResultsError)

  """
  def get_plan!(id), do: Repo.get!(Plan, id)

  def get_plan_by_name!(name) do
    query =
      from p in Plan,
        where: p.name == ^name,
        limit: 1

    Repo.one!(query)
  end

  @doc """
  Creates a plan.

  ## Examples

      iex> create_plan(%{field: value})
      {:ok, %Plan{}}

      iex> create_plan(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_plan(attrs \\ %{}) do
    %Plan{}
    |> Plan.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a plan.

  ## Examples

      iex> update_plan(plan, %{field: new_value})
      {:ok, %Plan{}}

      iex> update_plan(plan, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_plan(%Plan{} = plan, attrs) do
    plan
    |> Plan.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a plan.

  ## Examples

      iex> delete_plan(plan)
      {:ok, %Plan{}}

      iex> delete_plan(plan)
      {:error, %Ecto.Changeset{}}

  """
  def delete_plan(%Plan{} = plan) do
    Repo.delete(plan)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking plan changes.

  ## Examples

      iex> change_plan(plan)
      %Ecto.Changeset{data: %Plan{}}

  """
  def change_plan(%Plan{} = plan, attrs \\ %{}) do
    Plan.changeset(plan, attrs)
  end
end
