# エンハンスドロードバランサ: sakuracloud_proxylb

エンハンスドロードバランサの情報を参照するためのデータソース

## Example Usage

```tf
data "sakuracloud_proxylb" "foobar" {
  filter {
    names = ["foobar"]
  }
}
```

<div class="editor">

<h2><a href="https://zouen-alpha.usacloud.jp/#data/proxylb" target="_blank" rel="noopener noreferrer">Code Editor</a></h2>

<iframe src="https://zouen-alpha.usacloud.jp/#data/proxylb"></iframe>

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
* `backend_http_keep_alive` - 実サーバとのHTTP持続接続
* `bind_port` - 待ち受けポートのリスト。詳細は[bind_portブロック](#bind_port)を参照
* `certificate` - 証明書のリスト。詳細は[certificateブロック](#certificate)を参照
* `description` - 説明
* `fqdn` - エンハンスドロードバランサにアクセスするためのFQDN。 通常CNAMEレコードの値として利用する
* `gzip` - コンテンツ配信時のgzip圧縮の有効フラグ
* `proxy_protocol` - Proxy Protocol v2の有効フラグ
* `syslog` - ログ出力先となるSyslogサーバ設定。詳細は[syslogブロック](#syslog)を参照
* `health_check` - ヘルスチェック。詳細は[health_checkブロック](#health_check)を参照
* `icon_id` - アイコンID
* `name` - 名前
* `plan` - プラン。次のいずれかとなる［`100`/`500`/`1000`/`5000`/`10000`/`50000`/`100000`]
* `proxy_networks` - エンハンスドロードバランサが実サーバにアクセスする際のアクセス元CIDRブロックのリスト
* `region` - エンハンスドロードバランサを設置するリージョン名。`anycast`を指定した場合は複数リージョンに設置される。次のいずれかとなる［`tk1`/`is1`/`anycast`]
* `rule` - ルールベースバランシングを行う際のルールのリスト。詳細は[ruleブロック](#rule)を参照
* `server` - 実サーバのリスト。詳細は[serverブロック](#server)を参照
* `sorry_server` - ソーリーサーバの設定。詳細は[sorry_serverブロック](#sorry_server)を参照
* `sticky_session` - Stickyセッション有効フラグ
* `tags` - タグ
* `timeout` - 実サーバのタイムアウト(秒数)
* `vip` - エンハンスドロードバランサに割り当てられたVIP
* `vip_failover` - VIPフェイルオーバ機能の有効フラグ

##### syslogブロック

* `server` - サーバのIPアドレス
* `port` - ポート番号

##### bind_portブロック

* `port` - ポート番号
* `proxy_mode` - 待ち受けモード。次のいずれかとなる［`http`/`https`/`tcp`]
* `redirect_to_https` - HTTPからHTTPSへのリダイレクト有効フラグ。 `proxy_mode`が`http`の場合にのみ使用される
* `response_header` - エンハンスドロードバランサが付与するレスポンスヘッダのリスト。詳細は[response_headerブロック](#response_header)を参照
* `support_http2` - HTTP/2の有効フラグ。 proxy_mode`が`https`の場合にのみ利用される
* `ssl_policy` - SSLポリシー

##### response_headerブロック

* `header` - ヘッダ名
* `value` - 値

##### certificateブロック

* `intermediate_cert` - 中間証明書
* `private_key` - 秘密鍵
* `server_cert` - サーバ証明書

##### additional_certificateブロック

* `intermediate_cert` - 中間証明書
* `private_key` - 秘密鍵
* `server_cert` - サーバ証明書

##### health_checkブロック

* `delay_loop` - チェック間隔秒数 
* `host_header` - HTTPチェック時に利用されるHostヘッダの値
* `path` - HTTPチェック時に利用されるリクエストパス
* `port` - TCPチェック時に利用されるポート番号
* `protocol` - プロトコル。次のいずれかとなる［`http`/`tcp`]

##### ruleブロック

* `action` - マッチした場合のアクション
* `group` - 振り分け先グループ名。 `host`と`path`にマッチするリクエストを受信した場合に同じ`group`の値を持つ実サーバに振り分けられる
* `source_ips` - 送信元IPアドレス or CIDRブロック
* `host` - リクエストのHostヘッダ
* `path` - リクエストパス

固定応答:
* `fixed_content_type` - 固定応答で返すContent-Type
* `fixed_message_body` - 固定応答で返すボディ
* `fixed_status_code` - 固定応答で返すステータスコード

リダイレクト:
* `redirect_location` - リダイレクト先 / 詳細は https://manual.sakura.ad.jp/cloud/appliance/enhanced-lb/#enhanced-lb-rule を参照
* `redirect_status_code` - リダイレクトで返すステータスコード



##### serverブロック

* `enabled` - 有効フラグ
* `group` - 振り分け先グループ名。 振り分けの挙動については[ruleブロック](#rule)を参照
* `ip_address` - IPアドレス
* `port` - ポート番号

##### sorry_serverブロック

* `ip_address` - IPアドレス
* `port` - ポート番号


