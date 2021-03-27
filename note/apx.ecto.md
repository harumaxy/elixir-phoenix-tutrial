# Ecto

Elixir の ORM

phx.new をインストールすると、データベースを作成・初期化する `ecto`コマンドも使えるようになる

```sh
mix ecto.create
```

`config/dev.exs` のDB情報を参照する
なお、postgres が立ち上がってないとエラーになる

```yml
# Use postgres/example user/password credentials
version: '3.1'

services:
  db:
    image: postgres
    restart: always
    environment:
      POSTGRES_PASSWORD: postgres
      POSTGRES_USER: postgres
      POSTGRES_DB: discuss_dev
    ports:
      - 5432:5432

  adminer:
    image: adminer
    restart: always
    ports:
      - 8080:8080
```