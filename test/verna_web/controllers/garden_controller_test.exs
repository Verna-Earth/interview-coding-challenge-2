defmodule VernaWeb.GardenControllerTest do
  use VernaWeb.ConnCase

  @create_attrs %{
    "beds" => [
      %{
        "x" => 0,
        "y" => 0,
        "width" => 250,
        "length" => 180,
        "soil_type" => "chalk"
      },
      %{
        "x" => 250,
        "y" => 300,
        "width" => 300,
        "length" => 300,
        "soil_type" => "loam"
      }
    ]
  }
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "create garden" do
    test "renders garden when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/gardens/create", @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/gardens/create", @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end
end
