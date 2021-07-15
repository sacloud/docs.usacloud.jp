# エンハンスドロードバランサ: sakuracloud_proxylb

## Example Usage

```tf
resource "sakuracloud_proxylb" "foobar" {
  name           = "foobar"
  plan           = 100
  vip_failover   = true
  sticky_session = true
  timeout        = 10
  region         = "is1"

  health_check {
    protocol    = "http"
    delay_loop  = 10
    host_header = "example.com"
    path        = "/"
  }

  sorry_server {
    ip_address = "192.0.2.1"
    port       = 80
  }

  syslog {
    server = "192.0.2.1"
    port   = 514
  }

  bind_port {
    proxy_mode = "http"
    port       = 80
    response_header {
      header = "Cache-Control"
      value  = "public, max-age=10"
    }
  }

  server {
    ip_address = sakuracloud_server.foobar.ip_address
    port       = 80
    group      = "group1"
  }
  rule {
    host  = "www.example.com"
    path  = "/"
    group = "group1"
  }

  description = "description"
  tags        = ["tag1", "tag2"]
}

resource sakuracloud_server "foobar" {
  name = "foobar"
  network_interface {
    upstream = "shared"
  }
}
```

<div class="editor">

<h2><a href="https://zouen-alpha.usacloud.jp/#resource/proxylb" target="_blank" rel="noopener noreferrer">Code Editor</a></h2>

<iframe src="https://zouen-alpha.usacloud.jp/#resource/proxylb"></iframe>

</div>


## Argument Reference

* `name` - (Required) 名前 / `1`-`64`文字で指定
* `vip_failover` - (Optional) VIPフェイルオーバ機能の有効フラグ / この値を変更するとリソースの再作成が行われる
* `plan` - (Optional) プラン / 次のいずれかを指定［`100`/`500`/`1000`/`5000`/`10000`/`50000`/`100000`]/ この値を変更するとリソースの再作成が行われる / デフォルト:`100`
* `region` - (Optional) エンハンスドロードバランサが配置されるリージョン / `anycast`を指定した場合は複数リージョンに設置される / 次のいずれかを指定［`tk1`/`is1`/`anycast`]/ この値を変更するとリソースの再作成が行われる / デフォルト:`is1`
* `timeout` - (Optional) 実サーバの通信タイムアウト秒数 / デフォルト:`10`
* `gzip` - (Optional) コンテンツ配信時のgzip圧縮の有効フラグ
* `syslog` - (Optional) ログ出力先となるSyslogサーバ設定。詳細は[syslogブロック](#syslog)を参照

##### syslogブロック

* `server` - (Optional) サーバのIPアドレス
* `port` - (Optional) ポート番号

#### 証明書関連

* `certificate` - (Optional) 証明書設定。詳細は[certificateブロック](#certificate)を参照

##### certificateブロック

!!! Note
    `server_cert`と`private_key`、`intermediate_cert`はエンハンスドロードバランサ ACME設定リソース(`sakuracloud_proxylb_acme`)を利用すると上書きされます。

* `additional_certificate` - (Optional) 追加証明書のリスト。詳細は[additional_certificateブロック](#additional_certificate)を参照
* `intermediate_cert` - (Optional) 中間証明書
* `private_key` - (Optional) 秘密鍵
* `server_cert` - (Optional) サーバ証明書

##### additional_certificateブロック

* `server_cert` - (Required) サーバ証明書
* `private_key` - (Required) 秘密鍵
* `intermediate_cert` - (Optional) 中間証明書

#### バランシング動作

* `bind_port` - (Required) 待ち受けポート設定のリスト。詳細は[bind_portブロック](#bind_port)を参照
* `health_check` - (Required) ヘルスチェック設定。詳細は[health_checkブロック](#health_check)を参照
* `rule` - (Optional) 振り分けルール設定のリスト。詳細は[ruleブロック](#rule)を参照
* `server` - (Optional) 実サーバ設定のリスト。詳細は[serverブロック](#server)を参照
* `sorry_server` - (Optional) ソーリーサーバ設定。詳細は[sorry_serverブロック](#sorry_server)を参照
* `sticky_session` - (Optional) Stickyセッションの有効フラグ

##### bind_portブロック

* `proxy_mode` - (Required) プロキシモード / 次のいずれかを指定［`http`/`https`/`tcp`]
* `port` - (Optional) 待ち受けポート番号
* `redirect_to_https` - (Optional) httpからhttpsへのリダイレクト有効化フラグ / `proxy_mode`が`http`の場合のみ有効
* `response_header` - (Optional) レスポンスに付与するHTTPヘッダのリスト。詳細は[response_headerブロック](#response_header)を参照
* `support_http2` - (Optional) HTTP/2を有効にするフラグ / `proxy_mode`が`https`の場合のみ有効
* `ssl_policy` - (Optional) SSLポリシー / 次のいずれかを指定［`TLS-1-2-2019-04`/`TLS-1-2-2021-06`/`TLS-1-3-2021-06`]

##### response_headerブロック

* `header` - (Required) ヘッダ名
* `value` - (Required) 値

##### health_checkブロック

* `protocol` - (Required) プロトコル / 次のいずれかを指定［`http`/`tcp`]
* `delay_loop` - (Optional) チェック間隔秒数 / `10`-`60`の範囲で指定
* `host_header` - (Optional) HTTPチェック時のHostヘッダの値
* `path` - (Optional) HTTPチェック時のリクエストパス
* `port` - (Optional) TCPチェック時のポート番号

##### ruleブロック

* `action` - (Optional) マッチした場合のアクション / 次のいずれかを指定［`forward`(デフォルト)/`redirect`/`fixed`]
* `group` - (Optional) 振り分け先グループ名 / `host`と`path`にマッチするリクエストを受信した場合に同じ`group`の値を持つ実サーバに振り分けられる / `1`-`10`文字で指定
* `host` - (Optional) リクエストのHostヘッダ
* `path` - (Optional) リクエストパス

固定応答:
* `fixed_content_type` - (Optional) 固定応答で返すContent-Type/次のいずれかを指定［`text/plain`/`text/html`/`application/javascript`/`application/json`]
* `fixed_message_body` - (Optional) 固定応答で返すボディ
* `fixed_status_code` - (Optional) 固定応答で返すステータスコード/次のいずれかを指定［`200`/`403`/`503`]
  
リダイレクト:
* `redirect_location` - (Optional) リダイレクト先/詳細は https://manual.sakura.ad.jp/cloud/appliance/enhanced-lb/#enhanced-lb-rule を参照
* `redirect_status_code` - (Optional) リダイレクトで返すステータスコード/次のいずれかを指定［`301`/`302`]


##### serverブロック

* `ip_address` - (Required) IPアドレス
* `port` - (Required) ポート番号 / `1`-`65535`の範囲で指定
* `enabled` - (Optional) 有効フラグ
* `group` - (Optional) 振り分け先グループ名 / 振り分けの挙動については[ruleブロック](#rule)を参照 

##### sorry_serverブロック

* `ip_address` - (Required) IPアドレス
* `port` - (Optional) ポート番号

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
* `fqdn` - エンハンスドロードバランサにアクセスするためのFQDN / 通常CNAMEレコードの値として利用する
* `proxy_networks` - エンハンスドロードバランサが実サーバにアクセスする際のアクセス元CIDRブロックのリスト
* `vip` - 現在の仮想IPアドレス

