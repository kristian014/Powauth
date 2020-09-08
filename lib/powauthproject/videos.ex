defmodule Powauthproject.Videos do
  @moduledoc """
  The Multimedia context.
  """

  import Ecto.Query, warn: false
  alias Powauthproject.Repo
alias Powauthproject.Accounts.Video
   alias Powauthproject.Accounts.Category
    alias Powauthproject.Accounts
    # alias Powauthproject.Accounts.User
  @doc """
  Returns the list of videos.

  ## Examples

      iex> list_videos()
      [%Video{}, ...]

  """

  def create_category!(name) do
  Repo.insert!(%Category{name: name}, on_conflict: :nothing)
end


def list_alphabetical_categories do
  Category
  |> Category.alphabetical()
  |> Repo.all()
end



  def list_videos do
    Repo.all(Video)
  end


  def get_account_video(%Accounts.Account{} = account) do
    Video
    |> videos_query(account)
    |> Repo.all()
  end

  defp videos_query(query, %Accounts.Account{id: account_id}) do
    from(v in query, where: v.account_id == ^account_id)
  end

  def get_user_video!(%Accounts.Account{} = account, id) do
    Video
    |> videos_query(account)
    |> Repo.get!(id)
  end

  @doc """
  Gets a single video.

  Raises `Ecto.NoResultsError` if the Video does not exist.

  ## Examples

      iex> get_video!(123)
      %Video{}

      iex> get_video!(456)
      ** (Ecto.NoResultsError)

  """
  def get_video!(id), do: Repo.get!(Video, id)

  @doc """
  Creates a video.

  ## Examples

      iex> create_video(%{field: value})
      {:ok, %Video{}}

      iex> create_video(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  # def create_video(attrs \\ %{}) do
  #   %Video{}
  #   |> Video.changeset(attrs)
  #   |> Repo.insert()
  # end


  def create_video(attrs \\ %{}) do
    %Video{}
    |> Video.changeset(attrs)
    |> Repo.insert()
  end




  @doc """
  Updates a video.

  ## Examples

      iex> update_video(video, %{field: new_value})
      {:ok, %Video{}}

      iex> update_video(video, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_video(%Video{} = video, attrs) do
    video
    |> Video.changeset(attrs)
    |> Repo.update()
  end




  @doc """
  Deletes a video.

  ## Examples

      iex> delete_video(video)
      {:ok, %Video{}}

      iex> delete_video(video)
      {:error, %Ecto.Changeset{}}

  """
  def delete_video(%Video{} = video) do
    Repo.delete(video)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking video changes.

  ## Examples

      iex> change_video(video)
      %Ecto.Changeset{data: %Video{}}

  """
  def change_video(%Video{} = video, attrs \\ %{}) do
    Video.changeset(video, attrs)
  end
end
