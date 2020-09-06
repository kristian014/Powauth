defmodule PowauthprojectWeb.Plug.ReloadUser do
  @doc false

  @spec init(any()) :: any()
  def init(opts), do: opts

  @doc false
  @spec call(Conn.t(), atom()) :: Conn.t()
  def call(conn, _opts) do
    config = Pow.Plug.fetch_config(conn)

    case Pow.Plug.current_user(conn, config) do
      nil ->
        conn

      user ->
        reloaded_user = Powauthproject.Repo.get!(Powauthproject.Users.User, user.id)

        Pow.Plug.assign_current_user(conn, reloaded_user, config)
    end
  end
end
