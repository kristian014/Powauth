defmodule Powauthproject.Users do
 import Ecto.Query, warn: false
  alias Powauthproject.{Repo, Users.User}

  @type t :: %User{}

@spec create_admin(map()) :: {:ok, t()} | {:error, Ecto.Changeset.t()}
def create_admin(params) do
  %User{}
  |> User.changeset(params)
  |> User.changeset(%{role: "admin"})
  |> Repo.insert()
end

@spec set_admin_role(t()) :: {:ok, t()} | {:error, Ecto.Changeset.t()}
def set_admin_role(user) do
  user
  |> User.changeset(%{role: "admin"})
  |> Repo.update()
end
@spec is_admin?(t()) :: boolean()
 def is_admin?(%{role: "admin"}), do: true
 def is_admin?(_any), do: false

 def update_user_role(%User{} = user, attrs) do
    user
    |> User.role_changeset(attrs)
    |> Repo.update()
  end

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def delete_user(%User{} = user) do
      Repo.delete(user)
    end

    def create_user(attrs \\ %{}) do
   %User{}
   |> User.changeset(attrs)
   |> Repo.insert()
 end

 def get_user!(id), do: Repo.get!(User, id)

 def list_users do
    Repo.all(User)
  end

  def change_user(%User{} = user) do
   User.changeset(user, %{})
 end
end
