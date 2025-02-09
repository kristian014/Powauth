defmodule Powauthproject.Accounts.Category do
  use Ecto.Schema
  import Ecto.Changeset
    import Ecto.Query

  schema "categories" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(Category, attrs) do
    Category
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end

  def alphabetical(query) do
  from c in query, order_by: c.name
end
end
