defmodule VernaWeb.PlanControllerTest do
  use VernaWeb.ConnCase

  import Verna.PlantingFixtures

  @create_attrs %{
    name: "some name",
    beds: []
  }
  @invalid_attrs %{name: nil, beds: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "create plan" do
    test "renders plan when data is valid", %{conn: conn} do
      garden = garden_fixture()

      conn = post(conn, ~p"/api/plans/create", Map.put(@create_attrs, :garden_id, garden.id))
      assert %{"id" => id} = json_response(conn, 201)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/plans/create", @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "score plan" do
    setup [:create_plan]

    test "scores chosen plan", %{conn: conn, plan: plan} do
      conn = get(conn, ~p"/api/plans/score/#{plan.name}")
      assert response(conn, 200)

      assert %{
               "score" => 9.5
             } = json_response(conn, 200)
    end
  end

  defp create_plan(_) do
    garden = garden_fixture()
    bed_fixture(garden_id: garden.id)
    bed_fixture(garden_id: garden.id)

    plan =
      plan_fixture(
        garden_id: garden.id,
        beds: %{
          "beds" => [
            [
              %{
                "plant" => "tomato",
                "area" => 250
              },
              %{
                "plant" => "onion",
                "area" => 900
              }
            ],
            [
              %{
                "plant" => "carrot",
                "area" => 1000
              },
              %{
                "plant" => "pea",
                "area" => 1000
              }
            ]
          ]
        }
      )

    %{plan: plan}
  end
end
