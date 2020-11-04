defmodule PowauthprojectWeb.AdminController do
  use PowauthprojectWeb, :controller
alias Powauthproject.Users

def index(conn, _params) do
    users = Users.list_users()
    render(conn, "index.html", users: users)
  end

  def edit(conn, %{"id" => id}) do
    user = Users.get_user!(id)
     #IO.inspect(user, label: "Strange Input")
    changeset = Users.change_user(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end


  def update(conn, %{"id" => id, "user" => user_params}) do
     user = Users.get_user!(id)
     IO.inspect(user_params, label: "params")
    #IO.inspect(user, label "for user id" )
     case Users.update_user_role(user, user_params) do
       {:ok, _user} ->
         conn
         |> put_flash(:info, "User role updated successfully.")
         |> redirect(to: Routes.admin_path(conn, :index))

       {:error, %Ecto.Changeset{} = changeset} ->
         render(conn, "edit.html", user: user, changeset: changeset)
     end
   end

end
