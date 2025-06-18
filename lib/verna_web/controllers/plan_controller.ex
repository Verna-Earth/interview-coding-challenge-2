defmodule VernaWeb.PlanController do
  use VernaWeb, :controller

  alias Verna.Planting
  alias Verna.Planting.Plan
  alias Verna.JSONSchemas

  action_fallback VernaWeb.FallbackController

  def score(conn, %{"name" => name}) do
    plan = Planting.get_plan_by_name!(name)
    garden = Planting.get_garden_and_beds!(plan.garden_id)

    score_context = Plan.score_plan(plan, garden)

    render(conn, :score, score: score_context.score)
  end

  def create(conn, plan_data) do
    # TODO: ensure the area is less than the area of the bed

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
end
