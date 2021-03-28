defmodule DiscussWeb.AuthController do
  use DiscussWeb, :controller
  plug Ueberauth

  def callback(conn, params) do
    IO.puts("+++++")

    # conn.assignes には、ueberauth_github によってパースされたトークンが atom Map で入っている
    # email, username, picture  などなど
    IO.inspect(conn.assigns)
    IO.puts("+++++")
    IO.inspect(params)
    IO.puts("+++++")
  end
end
