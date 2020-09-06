defmodule PowauthprojectWeb.Pow.ControllerCallbacks do
  use Pow.Extension.Phoenix.ControllerCallbacks.Base

  @impl true
  def before_respond(Pow.Phoenix.RegistrationController, :create, {:ok, user, conn}, _config) do
    Powauthproject.Accounts.new_account(user.id)
    {:ok, user, conn}
  end
end
