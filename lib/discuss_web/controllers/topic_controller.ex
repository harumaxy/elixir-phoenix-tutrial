alias Discuss.Topic

defmodule DiscussWeb.TopicController do
  use DiscussWeb, :controller

  plug DiscussWeb.Plugs.RequireAuth when action in [:new, :create, :edit, :update, :delete]

  def index(conn, _params \\ %{}) do
    topics = Discuss.Repo.all(Topic)
    render(conn, "index.html", topics: topics)
  end

  def new(conn, _params \\ %{}) do
    changeset = Topic.changeset(%Topic{}, %{})

    # render macro : DiscussWeb.Topic~~~~ Namespace にある Viewの render 関数を呼び出してレスポンス
    # ３つ目の引数は Keywords.t で、渡した値をテンプレートで使える
    render(conn, "new.html", changeset: changeset)
  end

  # params: eex template のフォームから投稿したデータを格納する string Map
  # %{"_csrf_token" => "...", "topic" => %{"title" => "a"}
  def create(conn, %{"topic" => topic}) do
    import Ecto.Changeset

    changeset =
      Topic.changeset(%Topic{}, topic)
      |> validate_required([:title])
      |> validate_length(:title, max: 250)

    case(Discuss.Repo.insert(changeset)) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Topic Created")
        |> redirect(to: Routes.topic_path(conn, :index))

      {:error, err} ->
        render(conn, "new.html", changeset: err)
    end
  end
end
