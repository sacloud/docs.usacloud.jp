# ロードバランサ: sakuracloud_load_balancer

ロードバランサの情報を参照するためのデータソース

## Example Usage

```hcl
data "sakuracloud_load_balancer" "foobar" {
  filter {
    names = ["foobar"]
  }
}
```

<div class="editor">

<h2>Code Editor</h2>

<iframe src="https://zouen-alpha.usacloud.jp/#data/load_balancer"></iframe>

</div>


## Argument Reference

* `filter` - (Optional) 参照対象をフィルタリングするための条件。詳細は[filterブロック](#filter)を参照 
* `zone` - (Optional) 対象ゾーンの名前 (例: `is1a`, `tk1a`)  

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
* `icon_id` - アイコンID
* `name` - 名前
* `network_interface` - ネットワーク設定。詳細は[network_interfaceブロック](#network_interface)を参照
* `plan` - プラン。次のいずれかとなる［`standard`/`highspec`]
* `tags` - タグ
* `vip` - VIPのリスト。詳細は[vipブロック](#vip)を参照

##### network_interfaceブロック

* `gateway` - ゲートウェイIPアドレス
* `ip_addresses` - IPアドレスのリスト
* `netmask` - サブネットマスク長
* `switch_id` - スイッチID
* `vrid` - VRID

##### vipブロック

* `delay_loop` - チェック間隔秒数
* `description` - 説明
* `port` - ポート番号
* `server` - 実サーバのリスト。詳細は[serverブロック](#server)を参照
* `sorry_server` - ソーリーサーバのIPアドレス
* `vip` - VIP(仮想IPアドレス)

##### serverブロック

* `enabled` - 有効フラグ
* `ip_address` - IPアドレス
* `path` - HTTP/HTTPSチェック時に利用されるリクエストパス
* `protocol` - ヘルスチェックのプロトコル。次のいずれかとなる［`http`/`https`/`tcp`/`ping`]
* `status` - HTTP/HTTPSチェック時に利用されるレスポンスコード


