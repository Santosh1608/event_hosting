defmodule EventWeb.FallbackController do
  use EventWeb, :controller

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(json: EventWeb.ErrorJSON)
    |> render(:"404")
  end

  def call(conn, {:error, changeset = %Ecto.Changeset{}}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(json: EventWeb.ErrorJSON)
    |> render("changeset_error.json", changeset: changeset)
  end

  # This clause is an example of how to handle resources that cannot be found.
  def call(conn, {:error, :unauthorized}) do
    conn
    |> put_status(:unauthorized)
    |> put_view(json: EventWeb.ErrorJSON)
    |> render(:"401")
  end
end
