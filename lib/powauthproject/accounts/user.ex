defmodule Powauthproject.Accounts.User do
  use Ecto.Schema

  schema "users" do
    belongs_to :account, Powauthproject.Accounts.Account
    field :role, :string
  end
end
