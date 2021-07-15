# GSLB: sakuracloud_gslb

GSLBの情報を参照するためのデータソース

## Example Usage

```tf
data "sakuracloud_gslb" "foobar" {
  filter {
    names = ["foobar"]
  }
}
```

<div class="editor">

<h2><a href="https://zouen-alpha.usacloud.jp/#data/gslb" target="_blank" rel="noopener noreferrer">Code Editor</a></h2>

<iframe src="https://zouen-alpha.usacloud.jp/#data/gslb"></iframe>

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
* `description` - 説明
* `fqdn` - GSLBにアクセスするためのFQDN。通常CNAMEレコードの値として利用する
* `health_check` - 実サーバのヘルスチェック設定。詳細は[health_checkブロック](#health_check)を参照
* `icon_id` - アイコンID
* `name` - 名前
* `server` - 実サーバのリスト。詳細は[serverブロック](#server)を参照
* `sorry_server` - ソーリーサーバのIPアドレス
* `tags` - タグ
* `weighted` - 重み付け振り分けの有効化フラグ

##### health_checkブロック

* `delay_loop` - チェック間隔秒数
* `host_header` - HTTP/HTTPSチェック時に利用されるHostヘッダの値
* `path` - HTTP/HTTPSチェック時に利用されるリクエストパス
* `port` - TCPチェック時に利用されるポート番号
* `protocol` - プロトコル。次のいずれかとなる［`http`/`https`/`tcp`/`ping`]
* `status` - HTTP/HTTPSチェック時に利用されるレスポンスコード

##### serverブロック

* `enabled` - 有効フラグ
* `ip_address` - IPアドレス
* `weight` - 重み付け振り分けが有効な場合のウェイト


