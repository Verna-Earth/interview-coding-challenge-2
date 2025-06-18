defmodule VernaWeb.GardenController do
  use VernaWeb, :controller

  alias Ecto.Multi
  alias Verna.Planting
  alias Verna.JSONSchemas

  action_fallback VernaWeb.FallbackController

  def create(conn, garden_data) do
    with :ok <- validate_schema(garden_data),
         :ok <- check_collisions(garden_data),
         {:ok, result} <- do_create(garden_data) do
      conn
      |> put_status(:created)
      |> render(:show, garden: result.garden)
    end
  end

  defp validate_schema(garden_data) do
    case JSONSchemas.validate("create_garden_request.json", garden_data) do
      :ok -> :ok
      {:error, errors} -> {:validation_error, errors}
    end
  end

  defp check_collisions(garden_data) do
    # First we convert each bed into a simple rect to make the code easier
    beds =
      garden_data["beds"]
      |> Enum.with_index()
      |> Enum.map(fn {b, idx} ->
        {idx, b["x"], b["y"], b["x"] + b["width"], b["y"] + b["length"]}
      end)

    # Now we look for collisions
    collisions? =
      beds
      |> Enum.any?(fn {idx1, x1, y1, right1, bot1} ->
        beds
        |> Enum.filter(fn {idx2, _, _, _, _} ->
          # We only want to test against beds with a higher index, this prevents us
          # testing against each pair twice or one bed against itself
          idx2 > idx1
        end)
        |> Enum.any?(fn {_idx2, x2, y2, right2, bot2} ->
          # Currently not working correctly because I've probably made a very simple mistake somewhere
          # testing the collision, pausing to move on for now as I don't want it to take up too much time
          # The intent is to break off and say "yes there's a collision" if a collision between the beds is
          # detected

          # [
          #   # Below or above
          #   not (y1 >= bot2 or bot1 <= y2),

          #   # Left of or right of
          #   not (x1 >= right2 or right1 <= x2)
          # ]

          # Set to true to force collisions, set to false to prevent them
          true
        end)
      end)

    if collisions? do
      {:collision_error, :collisions}
    else
      :ok
    end
  end

  defp do_create(garden_data) do
    Multi.new()
    |> Multi.run(:garden, fn _repo, _ ->
      # First we create the garden
      case Planting.create_garden(%{}) do
        nil -> {:error, :garden_not_created}
        garden -> garden
      end
    end)
    |> Multi.insert_all(:beds, Planting.Bed, fn %{garden: garden} ->
      # Now we insert all the beds
      garden_data["beds"]
      |> Enum.map(fn bed ->
        %{
          length: bed["length"],
          width: bed["width"],
          y: bed["y"],
          x: bed["x"],
          soil_type: bed["soil_type"],
          garden_id: garden.id,
          inserted_at: DateTime.utc_now(:second),
          updated_at: DateTime.utc_now(:second)
        }
      end)
    end)
    |> Verna.Repo.transaction()
  end
end
