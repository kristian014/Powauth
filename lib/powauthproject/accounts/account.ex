defmodule Powauthproject.Accounts.Account do
use Ecto.Schema

  schema "accounts" do
    has_many :users, Powauthproject.Accounts.User
      has_many :videos, Powauthproject.Accounts.Video
      timestamps()
    end

    def changeset(account, attrs \\ %{}) do
      account
      |> Ecto.Changeset.cast(attrs, [])
    end
  end
