defmodule DiscussWeb.TopicController do
  use DiscussWeb, :controller

  def new(conn, params) do
    conn
    |> Plug.Conn.send_resp(200, "NEW")
  end
end
