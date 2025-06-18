defmodule VernaWeb.GardenController do
  use VernaWeb, :controller

  alias Ecto.Multi
  alias Verna.Planting
  alias Verna.Planting.Garden

  action_fallback VernaWeb.FallbackController


  def create(conn, %{"_json" => bed_list}) do
    # TODO: validate schema

    result =
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
        bed_list
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

    case result do
      {:ok, actual_result} ->
        conn
        |> put_status(:created)
        |> render(:show, garden: actual_result.garden)

      {:error, reason} ->
        raise reason
    end
  end
end
