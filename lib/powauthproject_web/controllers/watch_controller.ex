defmodule PowauthprojectWeb.WatchController do
  use PowauthprojectWeb, :controller

  alias Powauthproject.Videos

  def show(conn, %{"id" => id}) do
    video = Videos.get_video!(id)
    render(conn, "show.html", video: video)
  end
end
