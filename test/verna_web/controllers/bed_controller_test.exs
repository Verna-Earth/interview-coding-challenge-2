defmodule VernaWeb.BedControllerTest do
  use VernaWeb.ConnCase

  import Verna.PlantingFixtures

  alias Verna.Planting.Bed

  @create_attrs %{
    length: 42,
    width: 42,
    y: 42,
    x: 42,
    soil_type: "some soil_type",
    garden_id: 42
  }
  @update_attrs %{
    length: 43,
    width: 43,
    y: 43,
    x: 43,
    soil_type: "some updated soil_type",
    garden_id: 43
  }
  @invalid_attrs %{length: nil, width: nil, y: nil, x: nil, soil_type: nil, garden_id: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all beds", %{conn: conn} do
      conn = get(conn, ~p"/api/beds")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create bed" do
    test "renders bed when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/beds", bed: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/beds/#{id}")

      assert %{
               "id" => ^id,
               "garden_id" => 42,
               "length" => 42,
               "soil_type" => "some soil_type",
               "width" => 42,
               "x" => 42,
               "y" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/beds", bed: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update bed" do
    setup [:create_bed]

    test "renders bed when data is valid", %{conn: conn, bed: %Bed{id: id} = bed} do
      conn = put(conn, ~p"/api/beds/#{bed}", bed: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/beds/#{id}")

      assert %{
               "id" => ^id,
               "garden_id" => 43,
               "length" => 43,
               "soil_type" => "some updated soil_type",
               "width" => 43,
               "x" => 43,
               "y" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, bed: bed} do
      conn = put(conn, ~p"/api/beds/#{bed}", bed: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete bed" do
    setup [:create_bed]

    test "deletes chosen bed", %{conn: conn, bed: bed} do
      conn = delete(conn, ~p"/api/beds/#{bed}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/beds/#{bed}")
      end
    end
  end

  defp create_bed(_) do
    bed = bed_fixture()
    %{bed: bed}
  end
end
