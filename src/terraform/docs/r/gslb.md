# GSLB: sakuracloud_gslb

## Example Usage

```hcl
resource "sakuracloud_gslb" "foobar" {
  name = "example"

  health_check {
    protocol    = "http"
    delay_loop  = 10
    host_header = "example.com"
    path        = "/"
    status      = "200"
  }

  sorry_server = "192.2.0.1"

  server {
    ip_address = "192.2.0.11"
    weight     = 1
    enabled    = true
  }
  server {
    ip_address = "192.2.0.12"
    weight     = 1
    enabled    = true
  }

  description = "description"
  tags        = ["tag1", "tag2"]
}
```

<div class="editor">

<h2>Code Editor</h2>

<iframe src="https://zouen-alpha.usacloud.jp/#resource/gslb"></iframe>

</div>


## Argument Reference

* `name` - (Required) 名前 / `1`-`64`文字で指定
* `health_check` - (Required) ヘルスチェック。詳細は[health_checkブロック](#health_check)を参照
* `server` - (Optional) 実サーバのリスト。詳細は[serverブロック](#server)を参照
* `weighted` - (Optional) 重み付け振り分けの有効フラグ
* `sorry_server` - (Optional) ソーリーサーバのIPアドレス

##### health_checkブロック

* `protocol` - (Required) プロトコル / 次のいずれかを指定［`http`/`https`/`tcp`/`ping`]
* `delay_loop` - (Optional) チェック間隔秒数 / `10`-`60`の範囲で指定
* `host_header` - (Optional) HTTP/HTTPSチェック時に利用されるHostヘッダの値
* `path` - (Optional) HTTP/HTTPSチェック時のリクエストパス
* `port` - (Optional) TCPチェック時のポート番号
* `status` - (Optional) HTTP/HTTPSチェック時のレスポンスコード

##### serverブロック

* `ip_address` - (Required) IPアドレス
* `enabled` - (Optional) 有効フラグ
* `weight` - (Optional) 重み付け振り分けが有効な場合のウェイト / `1`-`10000`の範囲で指定

#### Common Arguments

* `description` - (Optional) 説明 / `1`-`512`文字で指定
* `icon_id` - (Optional) アイコンID
* `tags` - (Optional) タグ


#### Timeouts

`timeouts`ブロックで[カスタムタイムアウト](https://www.terraform.io/docs/configuration/resources.html#operation-timeouts)が設定可能です。  

* `create` - 作成 (デフォルト: 5分)
* `update` - 更新 (デフォルト: 5分)
* `delete` - 削除 (デフォルト: 5分)

## Attribute Reference

* `id` - ID
* `fqdn` - GSLBにアクセスするためのFQDN。この値は通常CNAMEレコードの値として利用します

