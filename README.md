# 不動産のwebアプリ

## 使い方

このアプリケーションを動かす場合は、まずはリポジトリを手元にクローンしてください。
その後、dockerコマンドでビルドを行ってください。

```
$ docker-compose build
```

その後、データベースへのマイグレーションを実行します。

```
$ docker-compose run web rails db:migrate
```

マイグレーションを実行したらdockerを立ち上げます。
```
$ docker-compose up
```

ローカル
http://localhost:3000/

メールの確認
http://localhost:3000/letter_opener
