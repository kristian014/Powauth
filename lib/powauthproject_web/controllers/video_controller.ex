defmodule PowauthprojectWeb.VideoController do
  use PowauthprojectWeb, :controller


  alias Powauthproject.Videos

  plug :load_categories when action in [:new, :create, :edit, :update]

    defp load_categories(conn, _) do
      assign(conn, :categories, Videos.list_alphabetical_categories())
    end



    defp load_current_user(conn) do
      check_current_user = Pow.Plug.current_user(conn)
   Powauthproject.Accounts.lookup_account(check_current_user.account_id)
    end



  def index(conn, _params) do
      current_user = load_current_user(conn)
    videos = Videos.get_account_video(current_user)
    render(conn, "index.html", videos: videos)
  end

  def new(conn, _params, changeset \\ %{}) do
    current_user = load_current_user(conn)
    changeset = Powauthproject.Accounts.create_video(current_user, changeset )
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"video" => video_params}) do
  current_user = load_current_user(conn)
    changeset = Powauthproject.Accounts.create_video(current_user, video_params )
    case Powauthproject.Repo.insert(changeset) do
      {:ok, video} ->
        conn
        |> put_flash(:info, "Video created successfully.")
        |> redirect(to: Routes.video_path(conn, :show, video))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    current_user = load_current_user(conn)
    video = Videos.get_user_video!(current_user, id)
    render(conn, "show.html", video: video)
  end

  def edit(conn, %{"id" => id}) do
    current_user = load_current_user(conn)
    video = Videos.get_user_video!(current_user, id)
    changeset = Videos.change_video(video)
    render(conn, "edit.html", video: video, changeset: changeset)
  end

  def update(conn, %{"id" => id, "video" => video_params}) do
    current_user = load_current_user(conn)
    video = Videos.get_user_video!(current_user, id)
  if video.account_id === current_user.account_id do
    case Videos.update_video(video, video_params) do
      {:ok, video} ->
        conn
        |> put_flash(:info, "Video updated successfully.")
        |> redirect(to: Routes.video_path(conn, :show, video))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", video: video, changeset: changeset)
    end
    {:else, :unauthorised}
  end
  end


  def delete(conn, %{"id" => id}) do
  current_user = load_current_user(conn)
    video = Videos.get_user_video!(current_user, id)
    {:ok, _video} = Videos.delete_video(video)
    conn
    |> put_flash(:info, "Video deleted successfully.")
    |> redirect(to: Routes.video_path(conn, :index))
  end
end
