defmodule VernaWeb.PlanJSON do
  alias Verna.Planting.Plan

  @doc """
  Renders a list of plans.
  """
  def index(%{plans: plans}) do
    %{data: for(plan <- plans, do: data(plan))}
  end

  @doc """
  Renders a single plan.
  """
  def show(%{plan: plan}) do
    %{data: data(plan)}
  end

  def score(%{score: score_value}) do
    %{
      score: score_value
    }
  end

  defp data(%Plan{} = plan) do
    %{
      id: plan.id,
      name: plan.name,
      beds: plan.beds["beds"],
      garden_id: plan.garden_id
    }
  end
end
