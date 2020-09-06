defmodule Powauthproject.Repo do
  use Ecto.Repo,
    otp_app: :powauthproject,
    adapter: Ecto.Adapters.Postgres
end
