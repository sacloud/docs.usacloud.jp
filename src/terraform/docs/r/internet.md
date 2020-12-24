# スイッチ+ルータ: sakuracloud_internet

## Example Usage

```hcl
resource "sakuracloud_internet" "foobar" {
  name = "foobar"

  netmask     = 28
  band_width  = 100
  enable_ipv6 = false

  description = "description"
  tags        = ["tag1", "tag2"]
}
```

<div class="editor">

<h2>Code Editor</h2>

<iframe src="https://zouen-alpha.usacloud.jp/#resource/internet"></iframe>

</div>


## Argument Reference

* `name` - (Required) 名前 / `1`-`64`文字で指定
* `band_width` - (Optional) 帯域 / 次のいずれかを指定 [`100`/`250`/`500`/`1000`/`1500`/`2000`/`2500`/`3000`/`3500`/`4000`/`4500`/`5000`] / デフォルト:`100`
* `netmask` - (Optional) サブネットマスク長 / 次のいずれかを指定 [`26`/`27`/`28`] / この値を変更するとリソースの再作成が行われる / デフォルト:`28`
* `enable_ipv6` - (Optional) IPv6有効化フラグ

#### Common Arguments

* `description` - (Optional) 説明 / `1`-`512`文字で指定
* `icon_id` - (Optional) アイコンID
* `tags` - (Optional) タグ
* `zone` - (Optional) リソースを作成する対象ゾーンの名前(例: `is1a`, `tk1a`) / この値を変更するとリソースの再作成が行われる

#### Timeouts

`timeouts`ブロックで[カスタムタイムアウト](https://www.terraform.io/docs/configuration/resources.html#operation-timeouts)が設定可能です。  

* `create` - 作成 (デフォルト: 60分)
* `update` - 更新 (デフォルト: 60分)
* `delete` - 削除 (デフォルト: 20分)

## Attribute Reference

* `id` - ID
* `gateway` - ゲートウェイIPアドレス
* `ip_addresses` - スイッチ+ルータに割り当てられた、ユーザーが利用可能なIPアドレスのリスト
* `ipv6_network_address` - IPv6ネットワークアドレス
* `ipv6_prefix` - IPv6プレフィックス
* `ipv6_prefix_len` - IPv6プレフィックス長
* `max_ip_address` - スイッチ+ルータに割り当てられた、ユーザーが利用可能なIPアドレスの最大値
* `min_ip_address` - スイッチ+ルータに割り当てられた、ユーザーが利用可能なIPアドレスの最小値
* `network_address` - ネットワークアドレス
* `server_ids` - スイッチ+ルータに接続しているサーバのIDのリスト
* `switch_id` - スイッチID
