defmodule Powauthproject.Accounts.Video do
use Ecto.Schema
  import Ecto.Changeset

  schema "videos" do
    belongs_to :account, Powauthproject.Accounts.Account
    field :description, :string
    field :title, :string
    field :url, :string
      timestamps()
    end

    def changeset(video, attrs \\ %{}) do
      video
      |> cast(attrs, [:url, :title, :description, :account_id])
      |> validate_required([:url, :title, :description])
    end
  end
