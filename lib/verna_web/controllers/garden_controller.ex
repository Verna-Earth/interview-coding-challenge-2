defmodule VernaWeb.GardenController do
  use VernaWeb, :controller

  alias Verna.Planting
  alias Verna.Planting.Garden

  action_fallback VernaWeb.FallbackController

  def index(conn, _params) do
    gardens = Planting.list_gardens()
    render(conn, :index, gardens: gardens)
  end

  def create(conn, %{"garden" => garden_params}) do
    with {:ok, %Garden{} = garden} <- Planting.create_garden(garden_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/gardens/#{garden}")
      |> render(:show, garden: garden)
    end
  end

  def show(conn, %{"id" => id}) do
    garden = Planting.get_garden!(id)
    render(conn, :show, garden: garden)
  end

  def update(conn, %{"id" => id, "garden" => garden_params}) do
    garden = Planting.get_garden!(id)

    with {:ok, %Garden{} = garden} <- Planting.update_garden(garden, garden_params) do
      render(conn, :show, garden: garden)
    end
  end

  def delete(conn, %{"id" => id}) do
    garden = Planting.get_garden!(id)

    with {:ok, %Garden{}} <- Planting.delete_garden(garden) do
      send_resp(conn, :no_content, "")
    end
  end
end
