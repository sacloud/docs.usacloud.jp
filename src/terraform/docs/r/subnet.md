# サブネット: sakuracloud_subnet

## Example Usage

```tf
resource sakuracloud_internet "foobar" {
  name = "foobar"
}

resource "sakuracloud_subnet" "foobar" {
  internet_id = sakuracloud_internet.foobar.id
  next_hop    = sakuracloud_internet.foobar.min_ip_address
}
```

## Argument Reference

* `internet_id` - (Required) サブネットを割り当てるスイッチ+ルータのID / この値を変更するとリソースの再作成が行われる
* `next_hop` - (Required) ネクストホップのIPアドレス
* `netmask` - (Optional) サブネットのネットワークマスク長 / `26`-`28`の範囲で指定 / この値を変更するとリソースの再作成が行われる / デフォルト:`28`

#### Common Arguments

* `zone` - (Optional) リソースを作成する対象ゾーンの名前(例: `is1a`, `tk1a`) / この値を変更するとリソースの再作成が行われる

#### Timeouts

`timeouts`ブロックで[カスタムタイムアウト](https://www.terraform.io/docs/configuration/resources.html#operation-timeouts)が設定可能です。  

* `create` - 作成 (デフォルト: 60分)
* `update` - 更新 (デフォルト: 60分)
* `delete` - 削除 (デフォルト: 5分)

## Attribute Reference

* `id` - ID
* `ip_addresses` - サブネットに割り当てられた、ユーザーが利用可能なIPアドレスのリスト
* `max_ip_address` - サブネットに割り当てられた、ユーザーが利用可能なIPアドレスの最大値
* `min_ip_address` - サブネットに割り当てられた、ユーザーが利用可能なIPアドレスの最小値
* `network_address` - ネットワークアドレス
* `switch_id` - スイッチID

