defmodule Powauthproject.Repo.Migrations.AddUserAccount do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :account_id, references(:accounts)
    end
  end
end
