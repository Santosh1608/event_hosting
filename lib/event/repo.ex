defmodule Event.Repo do
  use Ecto.Repo,
    otp_app: :event,
    adapter: Ecto.Adapters.Postgres
end
