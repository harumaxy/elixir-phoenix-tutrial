defmodule Discuss.Repo.Migrations.AddUserIdToTopics do
  use Ecto.Migration


  # alter table マクロ
  # add とか drop とか

  # type reference(:other_table)
  # 外部テーブルのプライマリーキーの型を参照する？
  def change do
    alter table(:topics) do
      add :user_id, references(:users)
    end

  end
end
