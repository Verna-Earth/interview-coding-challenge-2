defmodule Verna.JSONSchemas do
  @moduledoc """
  Scaffolding pulled from my open source project - https://github.com/Teifion/angen/blob/master/lib/angen/helpers/json_schema_helper.ex
  """
  require Logger

  @spec load() :: :ok
  def load() do
    base_path = Application.get_env(:verna, :json_schema_path)

    schema_count =
      [
        "#{base_path}/*.json"
      ]
      |> Enum.map(&load_path/1)
      |> List.flatten()
      |> Enum.count()

    Logger.info("Loaded #{schema_count} json schemas")

    :ok
  end

  defp load_path(path) do
    path
    |> Path.wildcard()
    |> Enum.map(fn file_path ->
      contents =
        file_path
        |> File.read!()
        |> Jason.decode!()

      root =
        try do
          ExJsonSchema.Schema.resolve(contents)
        rescue
          e ->
            Logger.error("Error resolving schema for path #{file_path}")
            reraise e, __STACKTRACE__
        end

      Cachex.put(:protocol_schemas, root.schema["$id"], root)

      root
    end)
  end
end
