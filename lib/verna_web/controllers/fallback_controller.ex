defmodule VernaWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use VernaWeb, :controller

  # This clause handles errors returned by Ecto's insert/update/delete.
  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(json: VernaWeb.ChangesetJSON)
    |> render(:error, changeset: changeset)
  end

  # This clause is an example of how to handle resources that cannot be found.
  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(html: VernaWeb.ErrorHTML, json: VernaWeb.ErrorJSON)
    |> render(:"404")
  end

  # A clause for schema validation errors
  def call(conn, {:validation_error, errors}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(json: VernaWeb.ValidationJSON)
    |> render(:error, validation_errors: errors)
  end

  def call(conn, {:collision_error, _}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(json: VernaWeb.ErrorJSON)
    |> render(:"500-detail", %{errors: "Bed overlap error"})
  end

  def call(conn, {:bed_area_error, msg}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(json: VernaWeb.ErrorJSON)
    |> render(:"500-detail", %{errors: msg})
  end
end
