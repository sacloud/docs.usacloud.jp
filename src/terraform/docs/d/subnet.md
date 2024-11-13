# サブネット: sakuracloud_subnet

サブネットの情報を参照するためのデータソース

## Example Usage

```tf
variable internet_id {}
data sakuracloud_subnet "foobar" {
  internet_id = var.internet_id
  index       = 1
}
```

<div class="editor">

<h2><a href="https://zouen-alpha.usacloud.jp/#data/subnet" target="_blank" rel="noopener noreferrer">Code Editor</a></h2>

<iframe src="https://zouen-alpha.usacloud.jp/#data/subnet"></iframe>

</div>


## Argument Reference

* `index` - (Required) スイッチ+ルータに割り当てられたサブネットのインデックス
* `internet_id` - (Required) サブネットが割り当てられたスイッチ+ルータのID
* `zone` - (Optional) 対象ゾーンの名前 (例: `is1a`, `tk1a`) 


## Attribute Reference

* `id` - ID
* `ip_addresses` - サブネットに割り当てられた、ユーザーが利用可能なIPアドレスのリスト
* `max_ip_address` - サブネットに割り当てられた、ユーザーが利用可能なIPアドレスの最大値
* `min_ip_address` - サブネットに割り当てられた、ユーザーが利用可能なIPアドレスの最小値
* `netmask` - サブネットマスク長
* `network_address` - ネットワークアドレス
* `next_hop` - ネクストホップのIPアドレス
* `switch_id` - スイッチID
