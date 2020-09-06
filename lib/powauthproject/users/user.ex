defmodule Powauthproject.Users.User do
  use Ecto.Schema
     import Ecto.Changeset
  use Pow.Ecto.Schema
    use Pow.Extension.Ecto.Schema


  schema "users" do

     field :role, :string, null: false, default: "user"
      belongs_to :account, Powauthproject.Accounts.Account
    pow_user_fields()
    timestamps()
  end
  @spec changeset(Ecto.Schema.t() | Ecto.Changeset.t(), map()) :: Ecto.Changeset.t()
def changeset(user_or_changeset, attrs) do
  user_or_changeset
    |> pow_changeset(attrs)
      |> pow_extension_changeset(attrs)
  |> Ecto.Changeset.cast(attrs, [:role])
  |> Ecto.Changeset.validate_inclusion(:role, ~w(user admin))
end
end
