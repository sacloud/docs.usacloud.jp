# ローカルルータ: sakuracloud_local_router

## Example Usage

```tf
resource "sakuracloud_local_router" "foobar" {
  name        = "example"
  description = "descriptio"
  tags        = ["tag1", "tag2"]

  switch {
    code     = sakuracloud_switch.foobar.id
    category = "cloud"
    zone_id  = "is1a"
  }

  network_interface {
    vip          = "192.168.11.1"
    ip_addresses = ["192.168.11.11", "192.168.11.12"]
    netmask      = 24
    vrid         = 101
  }

  static_route {
    prefix   = "10.0.0.0/24"
    next_hop = "192.168.11.2"
  }
  static_route {
    prefix   = "172.16.0.0/16"
    next_hop = "192.168.11.3"
  }

  peer {
    peer_id     = data.sakuracloud_local_router.peer.id
    secret_key  = data.sakuracloud_local_router.peer.secret_keys[0]
    description = "description"
  }
}

resource "sakuracloud_switch" "foobar" {
  name = "example"
}

data "sakuracloud_local_router" "peer" {
  filter {
    names = ["peer"]
  }
}

```

<div class="editor">

<h2><a href="https://zouen-alpha.usacloud.jp/#resource/local_router" target="_blank" rel="noopener noreferrer">Code Editor</a></h2>

<iframe src="https://zouen-alpha.usacloud.jp/#resource/local_router"></iframe>

</div>

## Argument Reference

* `name` - (Required) 名前 / `1`-`64`文字で指定
* `network_interface` - (Required) NIC設定。詳細は[network_interfaceブロック](#network_interface)を参照
* `switch` - (Required) 接続するスイッチの設定。詳細は[switchブロック](#switch)を参照
* `peer` - (Optional) ピア設定のリスト。詳細は[peerブロック](#peer)を参照
* `static_route` - (Optional) スタティックルート設定のリスト。詳細は[static_routeブロック](#static_route)を参照

##### network_interfaceブロック

* `ip_addresses` - (Required) IPアドレスのリスト
* `netmask` - (Required) サブネットマスク長 / `8`-`29`の範囲で指定
* `vip` - (Required) 仮想IPアドレス
* `vrid` - (Required) VRID

##### peerブロック

* `peer_id` - (Required) ピアのリソースID
* `secret_key` - (Required) ピアのシークレットキー
* `description` - (Optional) 説明 / `1`-`512`文字で指定
* `enabled` - (Optional) 有効フラグ

##### static_routeブロック

* `next_hop` - (Required) ネクストホップのIPアドレス
* `prefix` - (Required) プレフィックスCIDRブロック

##### switchブロック

* `category` - (Optional) 接続先スイッチのサービス名 (例: `cloud`, `vps`)
* `code` - (Required) 接続するスイッチのリソースID
* `zone_id` - (Required) 接続先スイッチの属するゾーン(例: `is1a`, `tk1a`)

!!! Note
    現在はさくらのクラウドのスイッチにのみ対応。  
    VPS/専用サーバは未対応です。  

#### Common Arguments

* `description` - (Optional) 説明 / `1`-`512`文字で指定
* `icon_id` - (Optional) アイコンID
* `tags` - (Optional) タグ

#### Timeouts

`timeouts`ブロックで[カスタムタイムアウト](https://www.terraform.io/docs/configuration/resources.html#operation-timeouts)が設定可能です。  

* `create` - 作成 (デフォルト: 20分)
* `update` - 更新 (デフォルト: 20分)
* `delete` - 削除 (デフォルト: 20分)

## Attribute Reference

* `id` - ID
* `secret_keys` - シークレットキーのリスト。他のローカルルータからピアリングする際に利用する

## Import

IDを指定する事でインポート可能です。

```bash
$ terraform import sakuracloud_local_router.example 123456789012
```