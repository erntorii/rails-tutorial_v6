# DockerによるRails環境構築

## SET UP

```
$ git clone https://github.com/erntorii/ECS-Rails6.git
$ cd ECS-Rails6
$ docker-compose run --rm app rails new . --force --database=mysql
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

puma.sockを配置するディレクトリを作成
```
$ mkdir -p tmp/sockets
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

## DBの作成
```
$ docker-compose run --rm app rails db:create
```
