defmodule Verna.PlantingTest do
  use Verna.DataCase

  alias Verna.Planting

  describe "gardens" do
    alias Verna.Planting.Garden

    import Verna.PlantingFixtures

    @invalid_attrs %{}

    test "list_gardens/0 returns all gardens" do
      garden = garden_fixture()
      assert Planting.list_gardens() == [garden]
    end

    test "get_garden!/1 returns the garden with given id" do
      garden = garden_fixture()
      assert Planting.get_garden!(garden.id) == garden
    end

    test "create_garden/1 with valid data creates a garden" do
      valid_attrs = %{}

      assert {:ok, %Garden{} = garden} = Planting.create_garden(valid_attrs)
    end

    test "create_garden/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Planting.create_garden(@invalid_attrs)
    end

    test "update_garden/2 with valid data updates the garden" do
      garden = garden_fixture()
      update_attrs = %{}

      assert {:ok, %Garden{} = garden} = Planting.update_garden(garden, update_attrs)
    end

    test "update_garden/2 with invalid data returns error changeset" do
      garden = garden_fixture()
      assert {:error, %Ecto.Changeset{}} = Planting.update_garden(garden, @invalid_attrs)
      assert garden == Planting.get_garden!(garden.id)
    end

    test "delete_garden/1 deletes the garden" do
      garden = garden_fixture()
      assert {:ok, %Garden{}} = Planting.delete_garden(garden)
      assert_raise Ecto.NoResultsError, fn -> Planting.get_garden!(garden.id) end
    end

    test "change_garden/1 returns a garden changeset" do
      garden = garden_fixture()
      assert %Ecto.Changeset{} = Planting.change_garden(garden)
    end
  end

  describe "beds" do
    alias Verna.Planting.Bed

    import Verna.PlantingFixtures

    @invalid_attrs %{length: nil, width: nil, y: nil, x: nil, soil_type: nil, garden_id: nil}

    test "list_beds/0 returns all beds" do
      bed = bed_fixture()
      assert Planting.list_beds() == [bed]
    end

    test "get_bed!/1 returns the bed with given id" do
      bed = bed_fixture()
      assert Planting.get_bed!(bed.id) == bed
    end

    test "create_bed/1 with valid data creates a bed" do
      valid_attrs = %{
        length: 42,
        width: 42,
        y: 42,
        x: 42,
        soil_type: "some soil_type",
        garden_id: 42
      }

      assert {:ok, %Bed{} = bed} = Planting.create_bed(valid_attrs)
      assert bed.length == 42
      assert bed.width == 42
      assert bed.y == 42
      assert bed.x == 42
      assert bed.soil_type == "some soil_type"
      assert bed.garden_id == 42
    end

    test "create_bed/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Planting.create_bed(@invalid_attrs)
    end

    test "update_bed/2 with valid data updates the bed" do
      bed = bed_fixture()

      update_attrs = %{
        length: 43,
        width: 43,
        y: 43,
        x: 43,
        soil_type: "some updated soil_type",
        garden_id: 43
      }

      assert {:ok, %Bed{} = bed} = Planting.update_bed(bed, update_attrs)
      assert bed.length == 43
      assert bed.width == 43
      assert bed.y == 43
      assert bed.x == 43
      assert bed.soil_type == "some updated soil_type"
      assert bed.garden_id == 43
    end

    test "update_bed/2 with invalid data returns error changeset" do
      bed = bed_fixture()
      assert {:error, %Ecto.Changeset{}} = Planting.update_bed(bed, @invalid_attrs)
      assert bed == Planting.get_bed!(bed.id)
    end

    test "delete_bed/1 deletes the bed" do
      bed = bed_fixture()
      assert {:ok, %Bed{}} = Planting.delete_bed(bed)
      assert_raise Ecto.NoResultsError, fn -> Planting.get_bed!(bed.id) end
    end

    test "change_bed/1 returns a bed changeset" do
      bed = bed_fixture()
      assert %Ecto.Changeset{} = Planting.change_bed(bed)
    end
  end
end
