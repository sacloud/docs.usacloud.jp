# シンプル監視: sakuracloud_simple_monitor

## Example Usage

```tf
resource "sakuracloud_simple_monitor" "foobar" {
  target = "www.example.com"

  delay_loop = 60
  health_check {
    protocol    = "https"
    port        = 443
    path        = "/"
    status      = "200"
    host_header = "example.com"
    sni         = true
    # username    = "username"
    # password    = "password"
  }

  description = "description"
  tags        = ["tag1", "tag2"]

  notify_email_enabled = true
  notify_email_html    = true
  notify_slack_enabled = true
  notify_slack_webhook = "https://hooks.slack.com/services/xxx/xxx/xxx"
}
```

<div class="editor">

<h2><a href="https://zouen-alpha.usacloud.jp/#resource/simple_monitor" target="_blank" rel="noopener noreferrer">Code Editor</a></h2>

<iframe src="https://zouen-alpha.usacloud.jp/#resource/simple_monitor"></iframe>

</div>


## Argument Reference

* `target` - (Required) 監視対象のIPアドレス、またはFQDN / この値を変更するとリソースの再作成が行われる
* `health_check` - (Required) ヘルスチェック設定。詳細は[health_checkブロック](#health_check)を参照
* `delay_loop` - (Optional) チェック間隔秒数 / `60`-`3600`の範囲で指定 / デフォルト:`60`
* `timeout` - (Optional) タイムアウト秒数 / `10`-`30`の範囲で指定 
* `enabled` - (Optional) 有効フラグ / デフォルト:`true`

!!! Note
    `target`はIPv4アドレス、またはAレコードが設定されたFQDNを指定する必要があります。  
    IPv6アドレスには対応していません

##### health_checkブロック

* `protocol` - (Required) プロトコル / 次のいずれかを指定［`http`/`https`/`ping`/`tcp`/`dns`/`ssh`/`smtp`/`pop3`/`snmp`/`sslcertificate`/`ftp`]
* `port` - (Optional) ポート番号

###### DNSチェック関連

* `excepcted_data` - (Optional) DNSチェック時の期待値
* `qname` - (Optional) DNSチェック時のクエリで利用するFQDN

###### HTTP/HTTPSチェック関連

* `host_header` - (Optional) HTTP/HTTPSチェック時のHostヘッダの値
* `password` - (Optional) HTTP/HTTPSチェック時のBASIC認証で利用するパスワード
* `username` - (Optional) HTTP/HTTPSチェック時のBASIC認証で利用するユーザー名
* `path` - (Optional) HTTP/HTTPSチェック時のリクエストパス
* `sni` - (Optional) HTTP/HTTPSチェック時のSNI有効フラグ
* `https` - (Optional) HTTP/HTTPSチェック時のHTTP/2有効フラグ
* `status` - (Optional) HTTP/HTTPSチェック時のレスポンスコード
* `contains_string` - (Optional) HTTP/HTTPSチェック時の期待するレスポンスボディ

###### 証明書チェック関連

* `remaining_days` - (Optional) 証明書チェックでの有効期限残日数の閾値 / `1`-`9999`の範囲で指定
* `verify_sni` - (Optional) ホスト名の検証

##### FTP関連

* `ftps` - (Optional) FTPS接続モード、次のいずれかを指定［``/`implicit`/`explicit`]

###### SNMP関連

* `community` - (Optional) SNMPコミュニティ名
* `oid` - (Optional) SNMP OID
* `snmp_version` - (Optional) SNMPバージョン / 次のいずれかを指定［`1`/`2c`]

#### 通知関連

* `notify_email_enabled` - (Optional) e-mailでの通知の有効フラグ / デフォルト:`true`
* `notify_email_html` - (Optional) e-mailでの通知時のHTMLメール有効フラグ
* `notify_interval` - (Optional) 再通知間隔(単位:時間) / `1`-`72`の範囲で指定 / デフォルト:`2`
* `notify_slack_enabled` - (Optional) slack/discordでの通知の有効フラグ
* `notify_slack_webhook` - (Optional) slack/discordでの通知で利用するWebhookのURL

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

