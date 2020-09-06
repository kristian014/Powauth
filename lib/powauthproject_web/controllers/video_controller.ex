defmodule PowauthprojectWeb.VideoController do
  use PowauthprojectWeb, :controller

alias PowauthprojectWeb.Plug.ReloadUser
  alias Powauthproject.Videos


  def index(conn, _params) do
      current_user = Pow.Plug.current_user(conn)
    videos = Videos.list_videos()
    render(conn, "index.html", videos: videos)
  end

  def new(conn, _params, changeset \\ %{}) do
      current_user = Pow.Plug.current_user(conn)
      account = Powauthproject.Accounts.lookup_account(current_user.account_id)
    changeset = Powauthproject.Accounts.create_video(account, changeset )
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"video" => video_params}) do
      current_user = Pow.Plug.current_user(conn)

        account = Powauthproject.Accounts.lookup_account(current_user.account_id)
        changeset = Powauthproject.Accounts.create_video(account, video_params )
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
    video = Videos.get_video!(id)
    render(conn, "show.html", video: video)
  end

  def edit(conn, %{"id" => id}) do
    video = Videos.get_video!(id)
    changeset = Videos.change_video(video)
    render(conn, "edit.html", video: video, changeset: changeset)
  end

  def update(conn, %{"id" => id, "video" => video_params}) do
    current_user = Pow.Plug.current_user(conn)
    video = Videos.get_video!(id)
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
    video = Videos.get_video!(id)
    {:ok, _video} = Videos.delete_video(video)

    conn
    |> put_flash(:info, "Video deleted successfully.")
    |> redirect(to: Routes.video_path(conn, :index))
  end
end
