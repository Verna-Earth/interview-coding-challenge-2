defmodule Verna.Knowledge do
  @moduledoc false

  defstruct ~w(name soil_types benefits_from)a

  def load_background_knowledge() do
    # Open up the json file, read it, decode it, put each entry into the cache
    Application.get_env(:verna, :knowledge_path)
    |> File.read!()
    |> Jason.decode!()
    |> Enum.each(fn row ->
      object = %Verna.Knowledge{
        name: row["name"],
        soil_types: row["soil_types"],
        benefits_from: row["benefits_from"]
      }

      Cachex.put(:background_knowledge, row["name"], object)
    end)
  end

  def get_knowledge(name) do
    # Using a case statement to make it explicit what the return types are
    # not everybody (including me) recalls the exact return shapes from every library
    case Cachex.get(:background_knowledge, name) do
      {:ok, nil} -> nil
      {:ok, value} -> value
    end
  end
end
