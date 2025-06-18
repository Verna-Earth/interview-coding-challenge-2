defmodule VernaWeb.PlanController do
  use VernaWeb, :controller

  alias Verna.Planting
  alias Verna.Planting.Plan
  alias Verna.JSONSchemas

  action_fallback VernaWeb.FallbackController

  def create(conn, plan_data) do
    with :ok <- validate_schema(plan_data),
         {:ok, plan} <- do_create(plan_data) do
      conn
      |> put_status(:created)
      |> render(:show, plan: plan)
    end
  end

  defp validate_schema(garden_data) do
    case JSONSchemas.validate("create_plan_request.json", garden_data) do
      :ok -> :ok
      {:error, errors} -> {:validation_error, errors}
    end
  end

  # Ecto isn't happy about us storing a json list as a map so we cheat and put it in a map
  defp do_create(data) do
    data
    |> Map.put("beds", %{"beds" => data["beds"]})
    |> Planting.create_plan()
  end

  # We'll be wanting to get the score for this later
  # def score(conn, %{"id" => id}) do
  #   plan = Planting.get_plan!(id)
  #   render(conn, :show, plan: plan)
  # end
end
