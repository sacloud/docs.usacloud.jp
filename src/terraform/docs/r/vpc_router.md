# VPCルータ: sakuracloud_vpc_router

## Example Usage

```tf
resource "sakuracloud_vpc_router" "standard" {
  name                = "standard"
  description         = "description"
  tags                = ["tag1", "tag2"]
  internet_connection = true
}

resource "sakuracloud_vpc_router" "premium" {
  name        = "premium"
  description = "description"
  tags        = ["tag1", "tag2"]
  plan        = "premium"

  internet_connection = true

  public_network_interface {
    switch_id    = sakuracloud_internet.foobar.switch_id
    vip          = sakuracloud_internet.foobar.ip_addresses[0]
    ip_addresses = [sakuracloud_internet.foobar.ip_addresses[1], sakuracloud_internet.foobar.ip_addresses[2]]
    aliases      = [sakuracloud_internet.foobar.ip_addresses[3]]
    vrid         = 1
  }

  private_network_interface {
    index        = 1
    switch_id    = sakuracloud_switch.foobar.id
    vip          = "192.168.11.1"
    ip_addresses = ["192.168.11.2", "192.168.11.3"]
    netmask      = 24
  }

  dhcp_server {
    interface_index = 1

    range_start = "192.168.11.11"
    range_stop  = "192.168.11.20"
    dns_servers = ["8.8.8.8", "8.8.4.4"]
  }

  dhcp_static_mapping {
    ip_address  = "192.168.11.10"
    mac_address = "aa:bb:cc:aa:bb:cc"
  }

  dns_forwarding {
    interface_index = 1
    dns_servers = ["133.242.0.3", "133.242.0.4"]
  }

  firewall {
    interface_index = 1

    direction = "send"
    expression {
      protocol            = "tcp"
      source_network      = ""
      source_port         = "80"
      destination_network = ""
      destination_port    = ""
      allow               = true
      logging             = true
      description         = "desc"
    }

    expression {
      protocol            = "ip"
      source_network      = ""
      source_port         = ""
      destination_network = ""
      destination_port    = ""
      allow               = false
      logging             = true
      description         = "desc"
    }
  }

  l2tp {
    pre_shared_secret = "example"
    range_start       = "192.168.11.21"
    range_stop        = "192.168.11.30"
  }

  port_forwarding {
    protocol     = "udp"
    public_port  = 10022
    private_ip   = "192.168.11.11"
    private_port = 22
    description  = "desc"
  }

  pptp {
    range_start = "192.168.11.31"
    range_stop  = "192.168.11.40"
  }

  wire_guard {
    ip_address = "192.168.31.1/24"
    peer {
      name       = "example"
      ip_address = "192.168.31.11"
      public_key = "<your-public-key>"
    }
  }

  site_to_site_vpn {
    peer              = "10.0.0.1"
    remote_id         = "10.0.0.1"
    pre_shared_secret = "example"
    routes            = ["10.0.0.0/8"]
    local_prefix      = ["192.168.21.0/24"]
  }

  site_to_site_vpn_parameter {
    ike {
      lifetime = 28800
      dpd {
        interval = 15
        timeout  = 30
      }
    }
    esp {
      lifetime = 1800
    }
    encryption_algo = "aes256"
    hash_algo       = "sha256"
  }

  static_nat {
    public_ip   = sakuracloud_internet.foobar.ip_addresses[3]
    private_ip  = "192.168.11.12"
    description = "desc"
  }

  static_route {
    prefix   = "172.16.0.0/16"
    next_hop = "192.168.11.99"
  }

  user {
    name     = "username"
    password = "password"
  }

  scheduled_maintenance {
    day_of_week = "tue"
    hour        = 1
  }
}

resource "sakuracloud_internet" "foobar" {
  name = "foobar"
}

resource sakuracloud_switch "foobar" {
  name = "foobar"
}
```

<div class="editor">

<h2><a href="https://zouen-alpha.usacloud.jp/#resource/vpc_router" target="_blank" rel="noopener noreferrer">Code Editor</a></h2>

<iframe src="https://zouen-alpha.usacloud.jp/#resource/vpc_router"></iframe>

</div>


## Argument Reference

* `name` - (Required) 名前 / `1`-`64`文字で指定
* `internet_connection` - (Optional) インターネットへの接続を許可するフラグ / デフォルト:`true`
* `plan` - (Optional) プラン / 次のいずれかを指定［`standard`/`premium`/`highspec`/`highspec4000`]/ この値を変更するとリソースの再作成が行われる / デフォルト:`standard`
* `version` - (Optional) VPCルータのバージョン / この値を変更するとリソースの再作成が行われる / デフォルト:`2`  
* `syslog_host` - (Optional) syslogホストのIPアドレス

#### ネットワーク関連

* `public_network_interface` - (Required) パブリック側ネットワーク設定 / `plan`が`standard`以外の場合に必須 / 詳細は[public_network_interfaceブロック](#public_network_interface)を参照
* `private_network_interface` - (Required) プライベート側ネットワーク設定のリスト。詳細は[private_network_interfaceブロック](#private_network_interface)を参照

##### public_network_interfaceブロック

* `aliases` - (Optional) プライマリNICに割り当てるIPエイリアスのリスト
* `ip_addresses` - (Optional) プライマリNICのIPアドレスのリスト / この値を変更するとリソースの再作成が行われる
* `switch_id` - (Optional) プライマリNICが接続するスイッチのID / この値を変更するとリソースの再作成が行われる
* `vip` - (Optional) プライマリNICに割り当てる仮想IPアドレス /  この値を変更するとリソースの再作成が行われる
* `vrid` - (Optional) VRID / この値を変更するとリソースの再作成が行われる

##### private_network_interfaceブロック

* `index` - (Required) 対象NICのインデックス / `1`-`7`の範囲で指定
* `ip_addresses` - (Required) IPアドレスのリスト / `plan`が`standard`の場合は1つ、以外の場合は2つの要素を指定
* `netmask` - (Required) サブネットマスク長
* `switch_id` - (Required) スイッチID
* `vip` - (Optional) 仮想IPアドレス /  `plan`が`standard`以外の場合に必須

#### ルータ機能関連

* `firewall` - (Optional) ファイアウォール設定のリスト。詳細は[firewallブロック](#firewall)を参照
* `static_route` - (Optional) スタティックルート設定のリスト。詳細は[static_routeブロック](#static_route)を参照
* `site_to_site_vpn` - (Optional) サイト間VPN設定のリスト。詳細は[site_to_site_vpnブロック](#site_to_site_vpn)を参照
* `site_to_site_vpn_parameter` - (Optional) サイト間VPNパラメータのリスト。詳細は[site_to_site_vpn_parameterブロック](#site_to_site_vpn_parameter)を参照

##### firewallブロック

* `direction` - (Required) ファイアウォールを適用する通信方向 / 次のいずれかを指定［`send`/`receive`]
* `expression` - (Required) フィルタリングルールのリスト。詳細は[expressionブロック](#expression)を参照
* `interface_index` - (Optional) ファイアウォールを適用するNICのインデックス /  `0`-`7`の範囲で指定

##### expressionブロック

* `protocol` - (Required) プロトコル / 次のいずれかを指定［`tcp`/`udp`/`icmp`/`ip`]
* `allow` - (Required) ルールにマッチしたパケットを許可するフラグ
* `destination_network` - (Optional) 宛先IPアドレス、または宛先CIDRブロック (例: `192.0.2.1`, `192.0.2.0/24`)
* `destination_port` - (Optional) 宛先ポート番号、または宛先ポート番号範囲 (例: `1024`, `1024-2048`) / `protocol`が`tcp`/`udp`の場合に利用される
* `source_network` - (Optional) 送信元IPアドレス、または送信元CIDRブロック (例: `192.0.2.1`, `192.0.2.0/24`)
* `source_port` - (Optional) 送信元ポート、または送信元ポート範囲 (例: `1024`, `1024-2048`) / `protocol`が`tcp`/`udp`の場合に利用される
* `logging` - (Optional) ルールにマッチしたパケットのロギングを有効にするフラグ
* `description` - (Optional) 説明 /  `0`-`512`文字で指定

##### static_routeブロック

* `next_hop` - (Required) ネクストホップのIPアドレス
* `prefix` - (Required) プレフィックスのリスト / 各要素はCIDRブロックとして指定

##### site_to_site_vpnブロック

* `local_prefix` - (Required) ローカルプレフィックス / CIDRブロックとして指定
* `peer` - (Required) ピアのIPアドレス
* `pre_shared_secret` - (Required) 事前共有鍵 / `0`-`40`文字で指定
* `remote_id` - (Required) リモートID
* `routes` - (Required) 接続されたVPNのCIDRブロックのリスト

##### `site_to_site_vpn_parameter`ブロック

* `encryption_algo` - (Optional) 次のいずれかを指定［`aes128`/`aes256`]
* `hash_algo` - (Optional) 次のいずれかを指定［`sha1`/`sha256`]
* `ike` - (Optional) 詳細は[ikeブロック](#ike)を参照
* `esp` - (Optional) 詳細は[espブロック](#esp)を参照

##### `esp`ブロック

* `lifetime` - (Optional) デフォルト: `1800`

##### `ike`ブロック

* `dpd` - (Optional) 詳細は[dpdブロック](#dpd)を参照
* `lifetime` - (Optional) デフォルト: `28800`

##### `dpd`ブロック

* `interval` - (Optional) デフォルト: `15`
* `timeout` - (Optional) デフォルト: `30`

#### DHCP/NAT/Forwarding関連

* `dhcp_server` - (Optional) DHCPサーバ設定のリスト。詳細は[dhcp_serverブロック](#dhcp_server)を参照
* `dhcp_static_mapping` - (Optional) DHCPスタティックマッピング設定のリスト。詳細は[dhcp_static_mappingブロック](#dhcp_static_mapping)を参照
* `port_forwarding` - (Optional) ポートフォワーディング設定のリスト。詳細は[port_forwardingブロック](#port_forwarding)を参照
* `static_nat` - (Optional) スタティックNAT設定のリスト。詳細は[static_natブロック](#static_nat)を参照
* `dns_forwarding` - (Optional) DNSフォワーディング設定。詳細は[dns_forwardingブロック](#dns_forwarding)を参照

##### dhcp_serverブロック

* `interface_index` - (Required) DHCPサーバを有効にするNICのインデックス / `1`-`7`の範囲で指定
* `range_start` - (Required) DHCPクライアントに割り当てるIPアドレスの開始値
* `range_stop` - (Required) DHCPクライアントに割り当てるIPアドレスの終了値
* `dns_servers` - (Optional) DHCPクライアントに配布するDNSサーバのIPアドレスのリスト

##### dhcp_static_mappingブロック

* `ip_address` - (Required) DHCPクライアントに割り当てるIPアドレス
* `mac_address` - (Required) スタティックマッピングのキーとなるアクセス元MACアドレス

##### port_forwardingブロック

* `private_ip` - (Required) プライベート側IPアドレス
* `private_port` - (Required) プライベート側ポート番号
* `protocol` - (Required) プロトコル / 次のいずれかを指定［`tcp`/`udp`]
* `public_port` - (Required) パブリック側ポート番号
* `description` - (Optional) 説明 / `0`-`512`文字で指定

##### static_natブロック

* `private_ip` - (Required) プライベート側IPアドレス
* `public_ip` - (Required) パブリック側IPアドレス
* `description` - (Optional) 説明 / `0`-`512`文字で指定

##### dns_forwardingブロック

* `interface_index` - (Required) DNSフォワーディングを有効にするNICのインデックス / `1`-`7`の範囲で指定
* `dns_servers` - (Optional) フォワード先DNSサーバのIPアドレスのリスト


#### リモートアクセス関連

* `l2tp` - (Optional) L2TP/IPsec設定。詳細は[l2tpブロック](#l2tp)を参照
* `pptp` - (Optional) PPTP設定。詳細は[pptpブロック](#pptp)を参照
* `user` - (Optional) リモートアクセスユーザー設定のリスト。詳細は[userブロック](#user)を参照
* `wire_guard` - (Optional) WireGuardサーバ設定。詳細は[wire_guardブロック](#wire_guard)を参照

##### l2tpブロック

* `pre_shared_secret` - (Required) 事前共有鍵
* `range_start` - (Required) クライアントに割り当てるIPアドレスの開始値
* `range_stop` - (Required) クライアントに割り当てるIPアドレスの終了値

##### pptpブロック

* `range_start` - (Required) クライアントに割り当てるIPアドレスの開始値
* `range_stop` - (Required) クライアントに割り当てるIPアドレスの終了値

##### userブロック

* `name` - (Required) ユーザー名
* `password` - (Required) パスワード

##### wire_guardブロック

* `ip_address` - (Required) クライアントに割り当てるIPアドレスブロック、`xxx.xxx.xxx.xxx/nn`形式で指定
* `peer` - (Optional) WireGuardクライアント設定。詳細は[peerブロック](#peer)を参照

##### peerブロック

* `ip_address` - (Required) ピアのIPアドレス
* `name` - (Required) ピアの名前
* `public_key` - (Required) 公開鍵


#### メンテナンス関連

* `scheduled_maintenance` - (Optional) スケジュールメンテナンス設定。詳細は[scheduled_maintenanceブロック](#scheduled_maintenance)を参照
* 
##### `scheduled_maintenance`ブロック

* `day_of_week` - 曜日。 次のいずれかとなる［`sun`/`mon`/`tue`/`wed`/`thu`/`fri`/`sat`]
* `hour` - 開始時間


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
* `public_ip` - VPCルータのパブリックIP
* `public_netmask` - VPCルータのパブリック側サブネットマスク長

