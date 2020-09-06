defmodule Powauthproject.Repo.Migrations.AddVideoAccount do
  use Ecto.Migration

  def change do
    alter table(:videos) do
      add :account_id, references(:accounts)
    end
  end
end
