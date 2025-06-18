defmodule VernaWeb.GardenControllerTest do
  use VernaWeb.ConnCase

  import Verna.PlantingFixtures

  alias Verna.Planting.Garden

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all gardens", %{conn: conn} do
      conn = get(conn, ~p"/api/gardens")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create garden" do
    test "renders garden when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/gardens", garden: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/gardens/#{id}")

      assert %{
               "id" => ^id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/gardens", garden: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update garden" do
    setup [:create_garden]

    test "renders garden when data is valid", %{conn: conn, garden: %Garden{id: id} = garden} do
      conn = put(conn, ~p"/api/gardens/#{garden}", garden: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/gardens/#{id}")

      assert %{
               "id" => ^id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, garden: garden} do
      conn = put(conn, ~p"/api/gardens/#{garden}", garden: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete garden" do
    setup [:create_garden]

    test "deletes chosen garden", %{conn: conn, garden: garden} do
      conn = delete(conn, ~p"/api/gardens/#{garden}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/gardens/#{garden}")
      end
    end
  end

  defp create_garden(_) do
    garden = garden_fixture()
    %{garden: garden}
  end
end
