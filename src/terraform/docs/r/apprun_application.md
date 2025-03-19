# AppRun アプリケーション: sakuracloud_apprun_application

## Example Usage

```tf
resource "sakuracloud_apprun_application" "foobar" {
  name            = "foobar"
  timeout_seconds = 60
  port            = 80
  min_scale       = 0
  max_scale       = 1
  components {
    name       = "foobar"
    max_cpu    = "0.1"
    max_memory = "256Mi"
    deploy_source {
      container_registry {
        image    = "foorbar.sakuracr.jp/foorbar:latest"
        server   = "foorbar.sakuracr.jp"
        username = "user"
        password = "password"
      }
    }
    env {
      key   = "key"
      value = "value"
    }
    env {
      key   = "key2"
      value = "value2"
    }
    env {
      key   = "key3"
      value = "value3"
    }
    probe {
      http_get {
        path = "/"
        port = 80
        headers {
          name  = "name"
          value = "value"
        }
        headers {
          name  = "name2"
          value = "value2"
        }
      }
    }
  }
  traffics {
    version_index = 0
    percent       = 100
  }
}
```

<div class="editor">

<h2><a href="https://zouen-alpha.usacloud.jp/#resource/apprun_application" target="_blank" rel="noopener noreferrer">Code Editor</a></h2>

<iframe src="https://zouen-alpha.usacloud.jp/#resource/apprun_application"></iframe>

</div>

## Argument Reference

* `name` - (Required) アプリケーション名
* `timeout_seconds` - (Required) アプリケーションの公開URLにアクセスして、インスタンスが起動してからレスポンスが返るまでの時間制限
* `port` - (Required) アプリケーションがリクエストを待ち受けるポート番号
* `min_scale` - (Required) アプリケーション全体の最小スケール数
* `max_scale` - (Required) アプリケーション全体の最大スケール数
* `components` - (Required) アプリケーションのコンポーネント情報
* `traffics` - (Optional) アプリケーションのトラフィック情報

#### `components` ブロック

* `name` - (Required) コンポーネント名
* `max_cpu` - (Required) コンポーネントの最大CPU数 / 次のいずれかを指定［`0.1`/`0.2`/`0.3`/`0.4`/`0.5`/`0.6`/`0.7`/`0.8`/`0.9`/`1`］
* `max_memory` - (Required) コンポーネントの最大メモリ / 次のいずれかを指定［`256Mi`/`512Mi`/`1Gi`/`2Gi`］
* `deploy_source` - (Required) コンポーネントを構成するソース
* `env` - (Optional) コンポーネントに渡す環境変数
* `probe` - (Optional) コンポーネントのプローブ設定

#### `deploy_source` ブロック

* `container_registry` - (Optional) コンテナレジストリ

#### `container_registry` ブロック

* `image` - (Required) コンテナイメージ名
* `server` - (Optional) コンテナレジストリのサーバー名
* `username` - (Optional) コンテナレジストリの認証情報
* `password` - (Optional) コンテナレジストリの認証情報

#### `env` ブロック

* `key` - (Optional) 環境変数名
* `value` - (Optional) 環境変数の値

#### `probe` ブロック

* `http_get` - (Required) HTTP GETプローブタイプ

#### `http_get` ブロック

* `path` - (Required) HTTPサーバーへアクセスしプローブをチェックする際のパス
* `port` - (Required) HTTPサーバーへアクセスしプローブをチェックする際のポート番号
* `headers` - (Optional) HTTPサーバーへアクセスしプローブをチェックする際のヘッダー

#### `headers` ブロック

* `name` - (Optional) ヘッダーフィールド名
* `value` - (Optional) ヘッダーフィールド値

#### `traffics` ブロック

!!! Note
    アプリケーションを作成、更新した際、その設定情報をバージョンとして保存します。version_index は作成日時で降順にソートされたバージョンのリストのインデックスを指定します。例えばバージョンが3つある場合 `version_index = 0` は最新のバージョンを指し、`version_index = 2` は最も古いバージョンを指します。

* `version_index` - (Required) アプリケーションバージョンのインデックス
* `percent` - (Required) トラフィック分散の割合

### Timeouts

timeoutsブロックで[カスタムタイムアウト](https://www.terraform.io/docs/configuration/resources.html#operation-timeouts)が設定可能です。

* `create` - 作成 (デフォルト: 5分)
* `update` - 更新 (デフォルト: 5分)
* `delete` - 削除 (デフォルト: 20分)

## Attribute Reference

* `id` - AppRun アプリケーションのID
* `public_url` - 公開URL
* `status` - アプリケーションステータス
 
## Import

IDを指定する事でインポート可能です。

```bash
$ terraform import sakuracloud_apprun_application.example 123456789012
```
