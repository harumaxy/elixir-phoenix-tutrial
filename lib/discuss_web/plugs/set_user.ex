defmodule DiscussWeb.Plugs.SetUser do
  alias Discuss.User

  def init(_params) do
  end

  # nil && val = nil / val1 && val2 = val2
  def call(conn, _params) do
    user_id = Plug.Conn.get_session(conn, :user_id)
    user = user_id && Discuss.Repo.get(User, user_id)

    case user do
      nil -> Plug.Conn.assign(conn, :user, nil)
      user -> Plug.Conn.assign(conn, :user, user)
    end
  end
end
