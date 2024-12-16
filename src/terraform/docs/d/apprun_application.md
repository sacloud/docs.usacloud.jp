# AppRun アプリケーション: sakuracloud_apprun_application

AppRun アプリケーションの情報を参照するためのデータソース

## Example Usage

```tf
data "sakuracloud_apprun_application" "foobar" {
  name = "foobar"
}
```
## Argument Reference

* `name` - (Required) アプリケーション名

## Attribute Reference

* `id` - アプリケーションID
* `timeout_seconds` - アプリケーションの公開URLにアクセスして、インスタンスが起動してからレスポンスが返るまでの時間制限
* `port` - アプリケーションがリクエストを待ち受けるポート番号
* `min_scale` - アプリケーション全体の最小スケール数
* `max_scale` - アプリケーション全体の最大スケール数
* `components` - アプリケーションのコンポーネント情報
* `public_url` - 公開URL
* `status` - アプリケーションステータス

#### `components` ブロック

* `name` - コンポーネント名
* `max_cpu` - コンポーネントの最大CPU数
* `max_memory` - コンポーネントの最大メモリ
* `deploy_source` - コンポーネントを構成するソース
* `env` - コンポーネントに渡す環境変数
* `probe` - コンポーネントのプローブ設定

#### `deploy_source` ブロック

* `container_registry` - コンテナレジストリ

#### `container_registry` ブロック

* `image` - コンテナイメージ名
* `server` - コンテナレジストリのサーバー名
* `username` - コンテナレジストリの認証情報

#### `env` ブロック

* `key` - 環境変数名
* `value` - 環境変数の値

#### `probe` ブロック

* `http_get` - HTTP GETプローブタイプ

#### `http_get` ブロック

* `path` - HTTPサーバーへアクセスしプローブをチェックする際のパス
* `port` - HTTPサーバーへアクセスしプローブをチェックする際のポート番号
* `headers` - HTTPサーバーへアクセスしプローブをチェックする際のヘッダー

#### `headers` ブロック

* `name` - ヘッダーフィールド名
* `value` - ヘッダーフィールド値
