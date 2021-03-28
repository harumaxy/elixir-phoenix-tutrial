defmodule DiscussWeb.AuthController do
  use DiscussWeb, :controller
  plug Ueberauth

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, params) do
    IO.inspect(auth)
    user_params = %{token: auth.credentials.token, email: auth.info.email, provider: "github"}

    # 新規Insertの場合も Changeset が必要なので、empty record に update param を適用
    changeset = Discuss.User.changeset(%Discuss.User{}, user_params)
    signin(conn, changeset)
  end

  defp signin(conn, changeset) do
    case insert_or_update_user(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Weocome back!")
        # put_session でクッキーにセットされる値は暗号化されるので、ハイジャックされにくい
        |> put_session(:user_id, user.id)
        |> redirect(to: Routes.topic_path(conn, :index))

      {:error, _reason} ->
        conn
        |> put_flash(:info, "Error signing in")
        |> redirect(to: Routes.topic_path(conn, :index))
    end
  end

  def signout(conn, _params) do
    conn
    |> configure_session(drop: true)
    |> redirect(to: Routes.topic_path(conn, :index))
  end

  defp insert_or_update_user(changeset) do
    case Discuss.Repo.get_by(Discuss.User, email: changeset.changes.email) do
      nil ->
        Discuss.Repo.insert(changeset)

      user ->
        {:ok, user}
    end
  end
end
