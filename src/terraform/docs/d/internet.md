# スイッチ+ルータ: sakuracloud_internet

スイッチ+ルータの情報を参照するためのデータソース

## Example Usage

```tf
data "sakuracloud_internet" "foobar" {
  filter {
    names = ["foobar"]
  }
}
```

<div class="editor">

<h2><a href="https://zouen-alpha.usacloud.jp/#data/internet" target="_blank" rel="noopener noreferrer">Code Editor</a></h2>

<iframe src="https://zouen-alpha.usacloud.jp/#data/internet"></iframe>

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
* `band_width` - 帯域(Mbps単位)
* `description` - 説明
* `enable_ipv6` - IPv6有効フラグ
* `gateway` - ゲートウェイIPアドレス
* `icon_id` - アイコンID
* `ip_addresses` - スイッチ+ルータに割り当てられた、ユーザーが利用可能なIPアドレスのリスト
* `ipv6_network_address` - IPv6ネットワークアドレス
* `ipv6_prefix` - IPv6プレフィックス
* `ipv6_prefix_len` - IPv6プレフィックス長
* `max_ip_address` - スイッチ+ルータに割り当てられた、ユーザーが利用可能なIPアドレスの最大値
* `min_ip_address` - スイッチ+ルータに割り当てられた、ユーザーが利用可能なIPアドレスの最小値
* `name` - 名前
* `netmask` - ネットワークマスク長
* `network_address` - ネットワークアドレス
* `server_ids` - スイッチ+ルータに接続しているサーバのIDのリスト
* `switch_id` - スイッチID
* `tags` - タグ



