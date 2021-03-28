defmodule DiscussWeb.Plugs.RequireAuth do
  # Controller handler は plug のようなものと行ったが厳密には違う
  # plug の最終地点が handler
  # 途中で halt(conn) すると、そこで止まる
  def init(_params) do
  end

  def call(conn, _params) do
    if conn.assigns[:user] do
      conn
    else
      conn
      |> Phoenix.Controller.put_flash(:error, "You must be logged in.")
      |> Phoenix.Controller.redirect(to: Routes.topic_path(conn, :index))
      |> Plug.Conn.halt()
    end
  end
end
