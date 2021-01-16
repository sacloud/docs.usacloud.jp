# VPCルータ: sakuracloud_vpc_router

VPCルータの情報を参照するためのデータソース

## Example Usage

```hcl
data "sakuracloud_vpc_router" "foobar" {
  filter {
    names = ["foobar"]
  }
}
```

<div class="editor">

<h2>Code Editor</h2>

<iframe src="https://zouen-alpha.usacloud.jp/#data/vpc_router"></iframe>

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
* `dhcp_server` - DHCPサーバ設定のリスト。詳細は[dhcp_serverブロック](#dhcp_server)を参照
* `dhcp_static_mapping` - DHCPスタティックマッピング設定のリスト。詳細は[dhcp_static_mappingブロック](#dhcp_static_mapping)を参照
* `firewall` - ファイアウォール設定のリスト。詳細は[firewallブロック](#firewall)を参照
* `icon_id` - アイコンID
* `internet_connection` - インターネット接続の有効フラグ
* `l2tp` - L2TP/IPsec設定。詳細は[l2tpブロック](#l2tp)を参照
* `name` - 名前
* `plan` - プラン。次のいずれかとなる [`standard`/`premium`/`highspec`/`highspec4000`]
* `port_forwarding` - ポートフォワーディング設定のリスト。詳細は[port_forwardingブロック](#port_forwarding)を参照
* `pptp` - PPTP設定。詳細は[pptpブロック](#pptp)を参照
* `private_network_interface` - プライベート側NIC設定のリスト。詳細は[private_network_interfaceブロック](#private_network_interface)を参照
* `public_ip` - VPCルータに割り当てられたパブリックIPアドレス
* `public_netmask` - VPCルータに割り当てられたサブネットマスク長
* `public_network_interface` - パブリック側NIC設定。詳細は[public_network_interfaceブロック](#public_network_interface)を参照
* `site_to_site_vpn` - サイト間VPN設定のリスト。詳細は[site_to_site_vpnブロック](#site_to_site_vpn)を参照
* `static_nat` - スタティックNAT設定のリスト。`plan`が`standard`以外の場合のみ参照可能。詳細は[static_natブロック](#static_nat)を参照
* `static_route` - スタティックルート設定のリスト。詳細は[static_routeブロック](#static_route)を参照
* `syslog_host` - VPCルータのログを送信するsyslogホストのIPアドレス
* `tags` - タグ
* `user` - リモートアクセスユーザー設定のリスト。詳細は[userブロック](#user)を参照
* `version` - VPCルータのバージョン

##### dhcp_serverブロック

* `dns_servers` - DHCPクライアントに配布するDHCPサーバのIPアドレスのリスト
* `interface_index` - DHCPサーバを有効にするNICのインデックス。次のいずれかとなる [`1`-`7`]
* `range_start` - DHCPクライアントに割り当てるIPアドレスの開始値
* `range_stop` - DHCPクライアントに割り当てるIPアドレスの終了値

##### dhcp_static_mappingブロック

* `ip_address` - DHCPクライアントに割り当てるIPアドレス
* `mac_address` - DHCPクライアントのMACアドレス

##### firewallブロック

* `direction` - ファイアウォールを適用する方向。次のいずれかとなる [`send`/`receive`]
* `expression` - ファイアウォールのルールのリスト。詳細は[expressionブロック](#expression)を参照
* `interface_index` - ファイアウォールを適用するNICのインデックス。次のいずれかとなる [`0`-`7`]

##### expressionブロック

* `allow` - マッチしたパケットの通信を許可するフラグ
* `description` - 説明
* `destination_network` - 宛先IPアドレス、または宛先CIDRブロック。次のような値となる `192.0.2.1`, `192.0.2.0/24`
* `destination_port` - 宛先ポート番号、または宛先ポート番号範囲。`protocol`が`tcp`/`udp`の場合に利用される。次のような値となる `1024`, `1024-2048`
* `logging` - マッチしたパケットのロギング有効フラグ
* `protocol` - プロトコル。次のいずれかとなる [`tcp`/`udp`/`icmp`/`ip`]
* `source_network` - 送信元IPアドレス、または送信元CIDRブロック。次のような値となる `192.0.2.1`, `192.0.2.0/24`
* `source_port` - 送信元ポート、または送信元ポート範囲。 `protocol`が`tcp`/`udp`の場合に利用される。次のような値となる `1024`, `1024-2048`

##### l2tpブロック

* `pre_shared_secret` - 事前共有鍵
* `range_start` - クライアントに割り当てるIPアドレスの開始値
* `range_stop` - クライアントに割り当てるIPアドレスの終了値

##### port_forwardingブロック

* `description` - 説明
* `private_ip` - プライベート側IPアドレス
* `private_port` - プライベート側ポート番号
* `protocol` - プロトコル。次のいずれかとなる [`tcp`/`udp`]
* `public_port` - パブリック側ポート番号

##### pptpブロック

* `range_start` - クライアントに割り当てるIPアドレスの開始値
* `range_stop` - クライアントに割り当てるIPアドレスの終了値

##### private_network_interfaceブロック

* `index` - NICのインデックス。次のいずれかとなる [`1`-`7`]
* `ip_addresses` - NICに割り当てられたIPアドレスのリスト。 `plan`が`standard`の場合は1つ、以外の場合は2つの要素を持つ
* `netmask` - サブネットマスク長
* `switch_id` - スイッチID
* `vip` - 仮想IPアドレス。`plan`が`standard`以外の場合のみ参照可能

##### public_network_interfaceブロック

* `aliases` - VPCルータに割り当てられたIPエイリアスのリスト
* `ip_addresses` - IPアドレスのリスト
* `switch_id` - スイッチID
* `vip` - 仮想IP
* `vrid` - VRID

##### site_to_site_vpnブロック

* `local_prefix` - ローカルプレフィックス
* `peer` - ピアのIPアドレス
* `pre_shared_secret` - 事前共有鍵
* `remote_id` - 対抗ID
* `routes` - 接続されたVPNのCIDRブロックのリスト

##### static_natブロック

* `description` - 説明
* `private_ip` - プライベートIPアドレス
* `public_ip` - パブリックIPアドレス

##### static_routeブロック

* `next_hop` - ネクストホップのIPアドレス
* `prefix` - プレフィックスのリスト

##### userブロック

* `name` - ユーザー名
* `password` - パスワード


