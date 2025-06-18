defmodule Verna.Caches do
  @moduledoc """
  Cache for global runtime variables
  """

  use Supervisor

  def start_link(opts) do
    Supervisor.start_link(__MODULE__, :ok, opts)
  end

  @impl true
  def init(:ok) do
    children = [
      add_cache(:background_knowledge),
      add_cache(:protocol_schemas)
    ]

    Supervisor.init(children, strategy: :one_for_all)
  end

  @spec add_cache(atom, list) :: map()
  def add_cache(name, opts \\ []) when is_atom(name) do
    %{
      id: name,
      start:
        {Cachex, :start_link,
         [
           name,
           opts
         ]}
    }
  end
end
