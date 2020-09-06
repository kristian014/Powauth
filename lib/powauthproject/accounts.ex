defmodule Powauthproject.Accounts do
  import Ecto.Query
    alias Powauthproject.Repo
  alias Powauthproject.Accounts.User
alias Powauthproject.Accounts.Account
  alias Powauthproject.Accounts.Video


  def create_video(account, video_attrs ) do
    %Video{}
    |> Video.changeset(video_attrs)
    |> Ecto.Changeset.put_assoc(:account, account)
  end




  @doc """
  """
  def lookup_account(id) do
    Account
    |> Repo.get(id)
    |> Repo.preload(:videos)
    |> Repo.preload(:users)
  end



    @doc """
    """
    def new_account(user_id) do
      user = Repo.get(User, user_id)

      _account =
        %Account{users: [user]}
        |> Repo.insert()
    end

end
