# ローカルルータ: sakuracloud_local_router

ローカルルータの情報を参照するためのデータソース

## Example Usage

```tf
data "sakuracloud_local_router" "foobar" {
  filter {
    names = ["foobar"]
  }
}
```

<div class="editor">

<h2><a href="https://zouen-alpha.usacloud.jp/#data/local_router" target="_blank" rel="noopener noreferrer">Code Editor</a></h2>

<iframe src="https://zouen-alpha.usacloud.jp/#data/local_router"></iframe>

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
* `icon_id` - アイコンID
* `name` - 名前
* `network_interface` - NIC設定。詳細は[network_interfaceブロック](#network_interface)を参照
* `peer` - ピア設定のリスト。詳細は[peerブロック](#peer)を参照
* `secret_keys` - シークレットキーのリスト。他のローカルルータからピアリングする際に利用する
* `static_route` - スタティックルート設定のリスト。詳細は[static_routeブロック](#static_route)を参照
* `switch` - 接続するスイッチの設定。詳細は[switchブロック](#switch)を参照
* `tags` - タグ

##### network_interfaceブロック

* `ip_addresses` - IPアドレスのリスト
* `netmask` - サブネットマスク長
* `vip` - 仮想IPアドレス
* `vrid` - VRID

##### peerブロック

* `description` - 説明
* `enabled` - 有効フラグ
* `peer_id` - ピアのリソースID
* `secret_key` - ピアのシークレットキー

##### static_routeブロック

* `next_hop` - ネクストホップのIPアドレス
* `prefix` - プレフィックスCIDRブロック

#### switch

* `category` - 接続先スイッチのサービス名 (例: `cloud`, `vps`)
* `code` - 接続するスイッチのリソースID
* `zone_id` - 接続先スイッチの属するゾーン(例: `is1a`, `tk1a`)

!!! Note
    現在はさくらのクラウドのスイッチにのみ対応。  
    VPS/専用サーバは未対応です。  

