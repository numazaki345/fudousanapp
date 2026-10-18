# 不動産管理アプリ

建物・部屋の情報と顧客の希望条件を管理し、メールで物件を紹介するRailsアプリケーションです。

## 主な機能

- メールアドレス・パスワードでの会員登録とログイン、Google OAuthによるログイン
- 建物情報の登録・一覧・詳細・編集・削除（外観画像、住所、最寄り駅、徒歩分数、建物種別、構造など）
- 建物に紐づく複数の部屋の管理（画像、部屋番号、間取り、家賃、面積、階数）
- 建物名・都道府県・最寄り駅のキーワード検索と、家賃の範囲検索
- 登録日・家賃・駅からの徒歩分数による並び替え、一覧のページネーション
- 顧客情報の登録・一覧・編集・削除
- 顧客ごとの希望条件の登録・編集（エリア、家賃、間取り、建物種別、徒歩分数など）
- 顧客登録時の案内メールと、物件URLを含む紹介メールの送信

管理機能はログインが必要です。顧客向けの希望条件入力ページ（顧客詳細）と希望条件の操作は、ログインせずに利用できる実装です。
開発環境のメールはLetter Opener Webで確認します。

## 開発環境

| 項目 | リポジトリの設定 |
| --- | --- |
| Ruby | 3.3.1（`Gemfile`・`Gemfile.lock`・`Dockerfile`） |
| Rails | 8.0.2（`Gemfile.lock`） |
| Bundler | 2.5.9（`Gemfile.lock`） |
| MySQL | 8.0（Docker Compose） |
| Node.js | 20系（`Dockerfile`） |
| フロントエンド | Bootstrap 5、Sass、PostCSS、Importmap、Turbo、Stimulus |
| DBスキーマ管理 | Ridgepole 3.0.1とルートの`Schemafile` |
| 画像保存 | Active Storage（開発環境では`storage/`に保存） |

以下はDocker Compose v2を使う開発手順です。Dockerを起動し、ホストの3000番・3306番ポートを空けてください。
現在の設定には不整合があるため、末尾の「既知の設定上の注意点」も確認してください。

## セットアップ

### 1. リポジトリの取得と環境変数

```sh
git clone https://github.com/numazaki345/fudousanapp.git
cd fudousanapp
```

ルートに`.env`を作成します。既存のファイルがある場合は必要な項目を追記してください。

```dotenv
HOST=http://localhost:3000
GOOGLE_CLIENT_ID=your-google-client-id
GOOGLE_CLIENT_SECRET=your-google-client-secret
```

Googleログインを使う場合は、OAuthクライアントの認証情報を設定し、リダイレクトURIに`http://localhost:3000/users/auth/google_oauth2/callback`を登録します。
メールアドレス・パスワードでのログインにはGoogle認証情報を使用しません。
`.env`はGitの管理対象外です。実際の認証情報をコミットしないでください。

### 2. イメージのビルドとDBの起動

```sh
docker compose build
docker compose up -d db
docker compose logs db
```

MySQLのログで接続受付が始まったことを確認してから、DBを作成します。
開発用DB名は`config/database.yml`の`myapp_development`です。
Composeの`MYSQL_DATABASE`で作られる`mydatabase`とは別に作成します。

```sh
docker compose run --rm web bundle exec rails db:create
```

### 3. Schemafileの適用

DB構造は`db:migrate`ではなく、Ridgepoleで`Schemafile`を適用して管理します。
以下では対象の環境とスキーマファイルを明示し、Ridgepoleを直接実行します。

```sh
docker compose run --rm web bundle exec ridgepole -c config/database.yml -E development -f Schemafile --apply
```

### 4. フロントエンド依存関係とCSS

```sh
docker compose run --rm web yarn install --frozen-lockfile
docker compose run --rm web yarn build:css
```

### 5. サンプルデータの投入（任意）

```sh
docker compose run --rm web bundle exec rails db:seed
```

`db/seeds.rb`は以下の開発用データを作成します。

- ログイン用ユーザー：`test@test.com` / `test1234`（同じメールアドレスのユーザーが存在する場合は既存ユーザーを使用し、パスワードは変更しません）
- 建物・住所・部屋：各20件（建物画像には`lib/building_mansion2.png`を使用）
- 顧客・希望条件：各20件

再実行すると、ユーザー以外のサンプルデータは追加されます。

## アプリの起動と利用

現在のComposeの起動コマンドには引数なしの`bundle exec rails`が含まれているため、ここでは起動コマンドを明示して実行します。
DBはセットアップ手順で起動済みの状態にしてください。

```sh
docker compose run --rm --service-ports --no-deps web bash -c "rm -f tmp/pids/server.pid && exec bundle exec rails server -p 3000 -b 0.0.0.0"
```

| ページ | URL |
| --- | --- |
| アプリ（物件一覧） | http://localhost:3000/ |
| ログイン | http://localhost:3000/users/sign_in |
| 顧客一覧 | http://localhost:3000/clients |
| 開発環境のメール確認 | http://localhost:3000/letter_opener |

新規登録またはサンプルユーザーでログインし、物件・部屋・顧客を登録します。
顧客登録時の案内メールには希望条件入力ページへのリンクが含まれます。
開発環境では外部にメールを送信せず、Letter Opener Webに表示します。

CSSを編集するときは、別のターミナルで監視ビルドを起動します。

```sh
docker compose run --rm --no-deps web yarn watch:css
```

アプリは`Ctrl+C`、DBは`docker compose stop db`で停止します。

## DBスキーマの変更

`Schemafile`を編集し、差分を確認してから適用します。

```sh
docker compose run --rm web bundle exec ridgepole -c config/database.yml -E development -f Schemafile --apply --dry-run
docker compose run --rm web bundle exec ridgepole -c config/database.yml -E development -f Schemafile --apply
```

既存データがあるDBでは、削除・型変更を含む差分を確認してください。
`lib/tasks/app.rake`には`rails app:migrate`用のタスクもあります。削除許可オプションを含むため、このREADMEでは上記の直接実行を使用します。

## テスト

MySQLを起動した状態で、テスト用DB（`myapp_test`）にも`Schemafile`を適用します。

```sh
docker compose run --rm -e RAILS_ENV=test web bundle exec rails db:create
docker compose run --rm web bundle exec ridgepole -c config/database.yml -E test -f Schemafile --apply
docker compose run --rm -e RAILS_ENV=test web bundle exec rails test
```

## 既知の設定上の注意点

- `.ruby-version`は`ruby-3.1.2`のままで、`Gemfile`とDockerのRuby 3.3.1に一致していません。ホストで直接実行する場合はRuby 3.3.1を選択してください。
- `app:migrate`タスクはテーブル削除を許可する`--drop-table`や、主キー変更を許可する`--allow-pk-change`を指定しています。実行前に`lib/tasks/app.rake`の内容とDBの差分を確認してください。
- `docker-compose.yml`の`web.command`には引数なしの`bundle exec rails`が含まれています。このREADMEではサーバー起動コマンドを上書きしています。
- `bin/setup`は`db:prepare`を実行する既存の手順で、Ridgepoleによるスキーマ適用やCSSの準備は行いません。初回構築には上記のセットアップ手順を使用してください。
