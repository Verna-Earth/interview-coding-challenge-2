defmodule Verna.Repo do
  use Ecto.Repo,
    otp_app: :verna,
    adapter: Ecto.Adapters.Postgres
end
