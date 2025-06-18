defmodule VernaWeb.ValidationJSON do
  @moduledoc false
  def error(%{validation_errors: errors}) do
    # Errors come back in a tuple so we need to put them into an encodable format
    errors =
      errors
      |> Enum.map(fn {a, b} -> "#{b}: #{a}" end)

    %{errors: errors}
  end
end
