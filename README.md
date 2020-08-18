# DockerによるRails環境構築

## SET UP

```
$ git clone https://github.com/erntorii/ECS-Rails6.git
$ cd ECS-Rails6
$ docker-compose run --rm app rails new . --force --database=mysql --skip-bundle
```

## docker-compose.ymlの編集
```yml
version: '3'
services:
  app:
    # 省略...
    volumes:
      - .:/app
      - sockets:/app/tmp/sockets
      - public-data:/app/public #コメントアウトを外す
      - bundle:/usr/local/bundle #コメントアウトを外す
    # 省略...
  web:
    # 省略...
    volumes:
      - sockets:/app/tmp/sockets
      - public-data:/app/public #コメントアウトを外す
    # 省略...
volumes:
  sockets:
  public-data: #コメントアウトを外す
  bundle: #コメントアウトを外す
  db-data:
```

## puma.rbの編集
```
$ vi config/puma.rb
```

```rb
# 最終行に追加
app_root = File.expand_path("../..", __FILE__)
bind "unix://#{app_root}/tmp/sockets/puma.sock"
```

## database.ymlの編集
```
$ vi config/database.yml
```

```yml
default: &default
  adapter: mysql2
  encoding: utf8mb4
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  username: root
  password: password #編集
  host: db #編集
```

## イメージのビルドと起動
```
$ docker-compose up -d --build
```

## DBの作成
```
$ docker-compose run --rm app rails db:create
```

# 本番環境へのデプロイ時

## rails/Dockerfileの編集
```yml
# 最終行
RUN bundle exec rails assets:precompile #コメントアウトを外す
```

## nginx.confの編集
```conf
server {
  listen 80;
  server_name xx.xx.xx.xx; #デプロイ時にIPを変更する
```

## database.ymlの編集
```yml
production:
  <<: *default
  database: <%= ENV['DB_DATABASE'] %>
  host: <%= ENV['DB_HOST'] %>
  username: <%= ENV['DB_USERNAME'] %>
  password: <%= ENV['DB_PASSWORD'] %>
```

## イメージのビルドとpush
`docker-compose build`後、ECRリポジトリにpushする
