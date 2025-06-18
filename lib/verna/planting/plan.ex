defmodule Verna.Planting.Plan do
  use Ecto.Schema
  import Ecto.Changeset

  alias Verna.Knowledge

  @base_score 10

  schema "plans" do
    field :name, :string
    field :beds, :map
    belongs_to(:garden, Verna.Planting.Garden)

    timestamps(type: :utc_datetime)
  end

  @required_attrs ~w(name beds garden_id)a

  @doc false
  def changeset(plan, attrs) do
    plan
    |> cast(attrs, @required_attrs)
    |> validate_required(@required_attrs)
  end

  def score_plan(plan, garden_with_beds) do
    %{
      score: 0,
      scores: []
    }
    |> score_base(plan, garden_with_beds)
    |> beneficial_plants(plan, garden_with_beds)
    |> bed_usage(plan, garden_with_beds)
    |> preferred_soil(plan, garden_with_beds)
    |> mean_scores()
  end

  defp score_base(context, _plan, garden_with_beds) do
    new_scores =
      garden_with_beds.beds
      |> Enum.map(fn _ -> @base_score end)

    %{context | scores: new_scores}
  end

  # add one for each plant that is planted alongside a beneficial companion
  defp beneficial_plants(context, plan, _garden_with_beds) do
    new_scores =
      plan.beds["beds"]
      |> Enum.map(fn planed_bed ->
        # Get a list of all the plants planned for this bed
        planned_plants =
          planed_bed
          |> Enum.map(& &1["plant"])
          |> MapSet.new()

        planed_bed
        |> Enum.map(fn %{"plant" => plant_name} ->
          # What does this plant benefit from?
          benefits_from =
            Knowledge.get_knowledge(plant_name).benefits_from
            |> MapSet.new()

          # Now count the intersection of present benefits and benefits wanted by this plant
          MapSet.intersection(planned_plants, benefits_from)
          |> MapSet.to_list()
          |> Enum.count()
        end)
        # Now sum the benefits present for each plant in the planned bed
        |> Enum.sum()
      end)
      # Now we add the additional scores to the scores for that bed
      |> Enum.zip(context.scores)
      |> Enum.map(fn {s1, s2} -> s1 + s2 end)

    %{context | scores: new_scores}
  end

  # add one if the bed is fully planted (i.e. the area of the bed equals the summed areas of the planted vegetables)
  defp bed_usage(context, plan, garden_with_beds) do
    # Get area of each, if equal, give a point
    new_scores =
      garden_with_beds.beds
      |> Enum.zip(plan.beds["beds"])
      |> Enum.map(fn {garden_bed, plan_bed} ->
        garden_area = garden_bed.width * garden_bed.length

        plan_area =
          plan_bed
          |> Enum.map(fn %{"area" => area} -> area end)
          |> Enum.sum()

        if garden_area == plan_area, do: 1, else: 0
      end)
      # Now we add the additional scores to the scores for that bed
      |> Enum.zip(context.scores)
      |> Enum.map(fn {s1, s2} -> s1 + s2 end)

    %{context | scores: new_scores}
  end

  # deduct one for each plant that is not planted in its preferred soil type
  defp preferred_soil(context, plan, garden_with_beds) do
    new_scores =
      plan.beds["beds"]
      |> Enum.zip(garden_with_beds.beds)
      |> Enum.map(fn {planed_bed, %{soil_type: soil_type}} ->
        planed_bed
        |> Enum.map(fn %{"plant" => plant_name} ->
          # What does this plant benefit from?
          soil_types_accepted = Knowledge.get_knowledge(plant_name).soil_types

          # If the soil type we have is accepted, no change
          if Enum.member?(soil_types_accepted, soil_type), do: 0, else: -1
        end)
        # Now sum the deductions
        |> Enum.sum()
      end)
      # Now we add the additional scores to the scores for that bed
      |> Enum.zip(context.scores)
      |> Enum.map(fn {s1, s2} -> s1 + s2 end)

    %{context | scores: new_scores}
  end

  # Takes the scores for each bed, sums them, divides by the count to average them and arrive at the mean
  defp mean_scores(context) do
    score_sum =
      context.scores
      |> Enum.sum()

    mean_score = score_sum / Enum.count(context.scores)

    %{context | score: mean_score}
  end
end
