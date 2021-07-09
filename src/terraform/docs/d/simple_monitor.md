# シンプル監視: sakuracloud_simple_monitor

シンプル監視の情報を参照するためのデータソース

## Example Usage

```hcl
data "sakuracloud_simple_monitor" "foobar" {
  filter {
    names = ["foobar"]
  }
}
```

<div class="editor">

<h2>Code Editor</h2>

<iframe src="https://zouen-alpha.usacloud.jp/#data/simple_monitor"></iframe>

</div>


## Argument Reference

* `filter` - (Optional) 参照対象をフィルタリングするための条件。詳細は[filterブロック](#filter)を参照 

##### filterブロック

* `condition` - (Optional) APIリクエスト時に利用されるフィルタリング用パラメータ。詳細は[conditionブロック](#condition)を参照  
* `id` - (Optional) 対象リソースのID 
* `names` - (Optional) 対象リソースの名前。指定値と部分一致するリソースが参照対象となる。複数指定した場合はAND条件となる  
* `tags` - (Optional) 対象リソースが持つタグ。指定値と完全一致するリソースが参照対象となる。複数指定した場合はAND条件となる

##### conditionブロック

* `name` - (Required) 対象フィールド名。大文字/小文字を区別する  
* `values` - (Required) 対象フィールドの値。複数指定した場合はAND条件となる


## Attribute Reference

* `id` - ID
* `delay_loop` - チェック間隔秒数
* `description` - 説明
* `enabled` - 有効フラグ
* `health_check` - ヘルスチェック。詳細は[health_checkブロック](#health_check)を参照
* `icon_id` - アイコンID
* `notify_email_enabled` - e-mailでの通知の有効フラグ
* `notify_email_html` - e-mail通知でのHTMLメール有効フラグ
* `notify_interval` - 再通知間隔秒数
* `notify_slack_enabled` - slackでの通知の有効フラグ
* `notify_slack_webhook` - slack/discordでの通知を利用する場合のwebhookのURL
* `tags` - タグ
* `target` - 監視対象のIPアドレス、またはFQDN

##### health_checkブロック

* `community` - SNMPチェック時に利用されるSNMPコミュニティ名
* `excepcted_data` - DNSチェック時の期待値
* `host_header` - HTTP/HTTPSチェック時のリクエストのHostヘッダの値
* `oid` - SNMPチェック時に利用されるOID
* `password` - HTTP/HTTPSチェック時のBASIC認証で利用されるパスワード
* `path` - HTTP/HTTPSチェック時のリクエストパス
* `port` - 対象ポート番号
* `protocol` - プロトコル。次のいずれかとなる［`http`/`https`/`ping`/`tcp`/`dns`/`ssh`/`smtp`/`pop3`/`snmp`/`sslcertificate`]
* `qname` - DNSチェック時のクエリの値
* `remaining_days` - SSL証明書チェック時の証明書有効日数の閾値
* `sni` - HTTP/HTTPSチェック時のSNI有効フラグ
* `https` - HTTP/HTTPSチェック時のHTTP/2有効フラグ
* `snmp_version` - SNMPチェック時のSNMPバージョン
* `status` - HTTP/HTTPSチェック時のレスポンスコード
* `username` - HTTP/HTTPSチェック時のBASIC認証で利用されるユーザー名


