# モバイルゲートウェイ: sakuracloud_mobile_gateway

## Example Usage

```tf
resource "sakuracloud_mobile_gateway" "foobar" {
  name                = "foobar"
  internet_connection = true
  dns_servers         = data.sakuracloud_zone.zone.dns_servers

  private_network_interface {
    switch_id  = sakuracloud_switch.foobar.id
    ip_address = "192.168.11.101"
    netmask    = 24
  }

  description = "description"
  tags        = ["tag1", "tag2"]

  traffic_control {
    quota                = 256
    band_width_limit     = 64
    enable_email         = true
    enable_slack         = true
    slack_webhook        = "https://hooks.slack.com/services/xxx/xxx/xxx"
    auto_traffic_shaping = true
  }

  static_route {
    prefix   = "192.168.10.0/24"
    next_hop = "192.168.11.1"
  }
  static_route {
    prefix   = "192.168.10.0/25"
    next_hop = "192.168.11.2"
  }
  static_route {
    prefix   = "192.168.10.0/26"
    next_hop = "192.168.11.3"
  }
}

data sakuracloud_zone "zone" {}

resource "sakuracloud_switch" "foobar" {
  name = "foobar"
}
```

<div class="editor">

<h2><a href="https://zouen-alpha.usacloud.jp/#resource/mobile_gateway" target="_blank" rel="noopener noreferrer">Code Editor</a></h2>

<iframe src="https://zouen-alpha.usacloud.jp/#resource/mobile_gateway"></iframe>

</div>


## Argument Reference

* `name` - (Required) 名前 / `1`-`64`文字で指定
* `dns_servers` - (Required) SIMから利用するDNSサーバのIPアドレスのリスト
* `inter_device_communication` - (Optional) 接続されたデバイス間での通信を許可するフラグ
* `internet_connection` - (Optional) 接続されたデバイスからインターネットへの接続を許可するフラグ
* `private_network_interface` - (Optional) プライベート側NICの設定。詳細は[private_network_interfaceブロック](#private_network_interface)を参照
* `sim` - (Optional) 接続するSIMの設定リスト。詳細は[simブロック](#sim)を参照
* `sim_route` - (Optional) SIMルート設定のリスト。詳細は[sim_routeブロック](#sim_route)を参照
* `static_route` - (Optional) スタティックルート設定のリスト。詳細は[static_routeブロック](#static_route)を参照
* `traffic_control` - (Optional) トラフィックコントロール設定。詳細は[traffic_controlブロック](#traffic_control)を参照

##### private_network_interfaceブロック

* `ip_address` - (Required) IPアドレス
* `netmask` - (Required) サブネットマスク長 / `8`-`29`の範囲で指定
* `switch_id` - (Required) スイッチID

##### simブロック

* `ip_address` - (Required) IPアドレス
* `sim_id` - (Required) SIMのID

##### sim_routeブロック

* `prefix` - (Required) プレフィックス / CIDRブロックとして指定
* `sim_id` - (Required) 宛先となるSIMのID

##### static_routeブロック

* `next_hop` - (Required) ネクストホップIPアドレス
* `prefix` - (Required) プレフィックス / CIDRブロックとして指定

##### traffic_controlブロック

* `quota` - (Required) 通信制限を行う月間通信量の閾値
* `auto_traffic_shaping` - (Optional) `quota`を超えた際に自動で通信制限を有効にするフラグ
* `band_width_limit` - (Optional) 通信制限時の帯域
* `enable_email` - (Optional) e-mailでの通知の有効フラグ
* `enable_slack` - (Optional) slackでの通知の有効フラグ
* `slack_webhook` - (Optional) slackでの通知に利用されるWebhookのURL

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
* `public_ip` - パブリック側NICのIPアドレス
* `public_netmask` - パブリック側NICのサブネットマスク長


## Import

IDを指定する事でインポート可能です。

```bash
$ terraform import sakuracloud_modile_gateway.example 123456789012
```