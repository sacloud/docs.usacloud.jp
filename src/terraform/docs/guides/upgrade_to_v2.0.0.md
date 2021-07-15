# アップグレードガイド(v2.0.0)

terraform-provider-sakuracloud v1系をご利用中の方向けのアップグレードガイドです。

## 目次

- [概要](#overview)
- [追加/変更/削除されたリソース](#generalDiff)
    - [データソース](#dataSourcesDiff)
    - [リソース](#resourcesDiff)
- [各リソースの変更点](#diffDetail)
    - [プロバイダー](#diffProvider)
    - [データソースの変更点](#diffDetailDataSource)
        - [ブリッジ: `sakuracloud_bridge`](#dataSourceBridge)
        - [データベース: `sakuracloud_database`](#dataSourceDatabase)
        - [ディスク: `sakuracloud_disk`](#dataSourceDisk)
        - [DNS: `sakuracloud_dns`](#dataSourceDNS)
        - [GSLB: `sakuracloud_gslb`](#dataSourceGSLB)
        - [アイコン: `sakuracloud_icon`](#dataSourceIcon)
        - [ロードバランサ: `sakuracloud_load_balancer`](#dataSourceLocaBalancer)
        - [NFS: `sakuracloud_nfs`](#dataSourceNFS)
        - [パケットフィルタ : `sakuracloud_packet_filter`](#dataSourcePacketFilter)
        - [専有ホスト: `sakuracloud_private_host`](#dataSourcePrivateHost)
        - [エンハンスドロードバランサ: `sakuracloud_proxylb`](#dataSourceProxyLB)
        - [サーバ: `sakuracloud_server`](#dataSourceServer)
        - [シンプル監視: `sakuracloud_simple_monitor`](#dataSourceSimpleMonitor)
        - [サブネット: `sakuracloud_subnet`](#dataSourceSubnet)
        - [VPCルータ: `sakuracloud_vpc_router`](#dataSourceVPCRouter)
        - [ウェブアクセラレータ: `sakuracloud_webaccel`](#dataSourceWebAccel)
    - [リソースの変更点](#diffDetailResource)
        - [ブリッジ: `sakuracloud_bridge`](#resourceBridge)
        - [データベース: `sakuracloud_database`](#resourceDatabase)
        - [データベース(リードレプリカ): `sakuracloud_database_read_replica`](#resourceDatabaseReadReplica)
        - [ディスク: `sakuracloud_disk`](#resourceDisk)
        - [DNS: `sakuracloud_dns`](#resourceDNS)
        - [GSLB: `sakuracloud_gslb`](#resourceGSLB)
        - [アイコン: `sakuracloud_icon`](#resourceIcon)
        - [スイッチ+ルータ: `sakuracloud_internet`](#resourceInternet)
        - [IPv4逆引きレコード: `sakuracloud_ipv4_ptr`](#resourceIPv4PTR)
        - [ロードバランサ: `sakuracloud_loadbalancer`](#resourceLoadBalancer)
        - [モバイルゲートウェイ : `sakuracloud_mobile_gateway`](#resourceMobileGateway)
        - [NFS: `sakuracloud_nfs`](#resourceNFS)
        - [パケットフィルタ : `sakuracloud_packet_filter`](#resourcePacketFilter)
        - [パケットフィルタ (ルール): `sakuracloud_packet_filter_rule`](#resourcePacketFilterRule)
        - [専有ホスト: `sakuracloud_private_host`](#resourcePrivateHost)
        - [エンハンスドロードバランサ: `sakuracloud_proxylb`](#resourceProxyLB)
        - [エンハンスドロードバランサ(ACME): `sakuracloud_proxylb_acme`](#resourceProxyLBACME)
        - [サーバ: `sakuracloud_server`](#resourceServer)
        - [SIM: `sakuracloud_sim`](#resourceSIM)
        - [シンプル監視: `sakuracloud_simple_monitor`](#resourceSimpleMonitor)
        - [サブネット: `sakuracloud_subnet`](#resourceSubnet)
        - [スイッチ: `sakuracloud_switch`](#resourceSwitch)
        - [VPCルータ: `sakuracloud_vpc_router`](#resourceVPCRouter)
    
# 概要 {: #overview }

v1からv2へ移行する際のStateのマイグレーションはサポートされていません。  
このため、既存のv1を利用して作成されたリソースをv2に移行する場合は、tfファイルの変更だけでなく、手作業でのtfstateファイルの修正が必要になります。

当面v1のメンテナンスは継続されるため、リソースの再作成が許容できないケースなどではv1を継続利用することを推奨します。

!!! Note
    v1は今後バグ修正が中心となり、新規リソースの追加などはv2に対してのみ行われます。  
    さくらのクラウドの最新機能を利用したい場合はv2への移行をご検討ください。
    
# 追加/変更/削除されたリソース {: #generalDiff }

## データソース {: #dataSourcesDiff }

### 新旧対応表

| キー                               | データソース名       | v1  | v2       |
| ---                              | ---           | -------- | --------      |
| `sakuracloud_container_registry` | コンテナレジストリ     |     | ○        |
| `sakuracloud_local_router`       | ローカルルータ       |     | ○        |
| `sakuracloud_server_vnc_info`    | サーバ(VNC接続情報)  |     | ○        |
| `sakuracloud_webaccel`           | ウェブアクセラレータ    | ○   | (近日対応予定) |

!!! Note
    ウェブアクセラレータ向けデータソースはv2で近日実装予定です

### データソースの全体的な変更点 {: #dataSourceDiff }

### 検索条件の記載方法

v1では以下のように`name_selectors`や`tag_selectors`、`os_type`などのデータソースの検索条件をトップレベルに記載していましたが、
v2では`filter`配下に記載する形へ変更されました。

#### v1でのデータソース:

```tf
# v1でのデータソース
data "sakuracloud_archive" "foobar" {
  name_selectors = ["Ubuntu", "Server", "18"]
}
```

#### v2でのデータソース:

```tf
# v1でのデータソース
data "sakuracloud_archive" "foobar" {
  filter {
    names = ["Ubuntu", "Server", "18"]
  }
}
```

また、v2ではIDを検索条件として指定可能になりました。


```tf
# v1でのデータソース
data "sakuracloud_archive" "foobar" {
  filter {
    id = "123456789012"
  }
}
```

## リソース {: #resourcesDiff}

### 新旧対応表

| キー | データソース名         | v1                  | v2                      | 備考 | 
| --- | ---             | ---                        | ---                            | --- |
`sakuracloud_container_registry`	|	コンテナレジストリ	|		|	○	|	v2から導入	|
`sakuracloud_gslb_server`	|	GSLB(実サーバ)	|	○	|		|	GSLBリソースと統合	|
`sakuracloud_loadbalancer_server`	|	ロードバランサ(実サーバ)	|	○	|		|	ロードバランサリソースと統合	|
`sakuracloud_loadbalancer_vip`	|	ロードバランサ(VIP)	|	○	|		|	ロードバランサリソースと統合	|
`sakuracloud_local_router`	|	ローカルルータ	|		|	○	|	v2から導入	|
`sakuracloud_mobile_gateway_sim_route`	|	モバイルゲートウェイ (SIMルート)	|	○	|		|	モバイルゲートウェイ リソースと統合	|
`sakuracloud_mobile_gateway_static_route`	|	モバイルゲートウェイ (スタティックルート)	|	○	|		|	モバイルゲートウェイ リソースと統合	|
`sakuracloud_packet_filter_rule`	|	パケットフィルタ (ルール)	|	○	|		|	単一のルールを表すリソース。v2で廃止	|
`sakuracloud_packet_filter_rules`	|	パケットフィルタ (ルール)	|		|	○	|	ルール全体を表すリソース。v2から導入	|
`sakuracloud_server_connector`	|	サーバコネクタ	|	○	|		|	廃止	|
`sakuracloud_vpc_router_dhcp_server`	|	VPCルータ(DHCPサーバ)	|	○	|		|	VPCルータリソースに統合	|
`sakuracloud_vpc_router_dhcp_static_mapping`	|	VPCルータ(DHCPスタティックマッピング)	|	○	|		|	VPCルータリソースに統合	|
`sakuracloud_vpc_router_firewall`	|	VPCルータ(ファイアウォール)	|	○	|		|	VPCルータリソースに統合	|
`sakuracloud_vpc_router_interface`	|	VPCルータ(インターフェース)	|	○	|		|	VPCルータリソースに統合	|
`sakuracloud_vpc_router_l2tp`	|	VPCルータ(L2TP/IPsec)	|	○	|		|	VPCルータリソースに統合	|
`sakuracloud_vpc_router_port_forwarding`	|	VPCルータ(ポートフォワーディング)	|	○	|		|	VPCルータリソースに統合	|
`sakuracloud_vpc_router_pptp`	|	VPCルータ(PPTP)	|	○	|		|	VPCルータリソースに統合	|
`sakuracloud_vpc_router_site_to_site_vpn`	|	VPCルータ(サイト間VPN)	|	○	|		|	VPCルータリソースに統合	|
`sakuracloud_vpc_router_static_nat`	|	VPCルータ(スタティックNAT)	|	○	|		|	VPCルータリソースに統合	|
`sakuracloud_vpc_router_static_route`	|	VPCルータ(スタティックルート)	|	○	|		|	VPCルータリソースに統合	|
`sakuracloud_vpc_router_user`	|	VPCルータ(リモートアクセスユーザー)	|	○	|		|	VPCルータリソースに統合	|
`sakuracloud_webaccel_certificate`	|	ウェブアクセラレータ(証明書)	|	○	|		|	(近日実装予定)	|

### リソースの全体的な変更点 {: #resourceDiff }

#### 命名規則の変更

ブロックで記載する要素(例: パケットフィルタのルール)の名称を単数形に統一

- v1: `expressions` =>  v2: `expression`

詳細は各リソースの変更点をご確認ください。

#### 子リソースの廃止

VPCルータやロードバランサなどの子リソースを持つリソースについて、親リソースに統合されました。  
例: ロードバランサの実サーバ(`sakuracloud_load_balancer_server`など)

動的に子要素を増減させたいケースではTerraform v0.12で導入された[Dynamicブロック](https://www.terraform.io/docs/configuration/expressions.html#dynamic-blocks)を利用してください。

!!! Note
    DNSなどの一部のリソースでは子リソースが残ったままとなっています。これらのリソースでは親子でライフサイクルの異なるケースが一般的にあり得るためです。  
    (例: DNSのゾーンは複数プロジェクトで共通、各レコードは各プロジェクトごとに管理、というケースなど)  
    現在親子リソースになっていないリソースを親子に分割したいユースケースがある場合は[GitHub](https://github.com/sacloud/terraform-provider-sakuracloud)にIssueを投稿して要望を出してください。  
    ユースケースによっては実装する可能性があります。

#### Timeoutsブロックのサポート

各リソースで[timeoutsブロック](https://www.terraform.io/docs/configuration/resources.html#operation-timeouts)を指定可能になりました。

#### ゾーンのスキーマレベルでのバリデーションの廃止

これまでは各リソースのスキーマで静的に利用可能なゾーンを定義していましたが、v2ではプロバイダーブロックで`zones`を指定することにより動的に利用可能なゾーンを指定可能になりました。  
この影響で、入力値の検証が実行時となり`terraform validate`などでエラーを返さなくなりました。

#### タグなどでのデータ型変更

タグなどのいくつかの項目データ型が`schema.TypeList`から`schema.TypeSet`に変更されました。  
これまではリスト内の値を参照する際に`sakuracloud_server.tags[0]`のようにインデックスを指定して参照していましたが、v2では`sakuracloud_server.tags[NNNN(ハッシュ値)]`となりました。  
tfファイルでの値の定義方法については従来通り`tags = ["tag1", "tag2"]`という形式が利用可能です。  

変更された項目は以下の通りです。

- 各リソースの`tags`
- `sakuracloud_auto_backup.weekdays`
- `sakuracloud_database.backup.weekdays`
- `sakuracloud_sim.carrier`
- `sakuracloud_vpc_router.site_to_site_vpn.routes`
- `sakuracloud_vpc_router.site_to_site_vpn.local_prefix`


# 各リソースの変更点 {: #diffDetail }

## [プロバイダー](https://docs.usacloud.jp/terraform/provider/) {: #diffProvider }

#### プロファイル機能のサポート

v2から[Usacloud](https://github.com/sacloud/usacloud)互換のファイルベースの共有クレデンシャル(プロファイル)がサポートされました。  
詳細は[プロバイダーのドキュメント](https://docs.usacloud.jp/terraform/provider/)を参照してください。

#### 項目変更

- `retry_interval`(廃止/変更): さくらのクラウドAPIがレスポンスコード423(Locked)、または503(ServiceUnavailable)を返した場合にリトライする際の待ち時間秒数。  
v2ではExponential backoffアルゴリズムが導入され、最小待ち時間秒数:`retry_wait_min`と最大待ち時間秒数`retry_wait_max`の2つの項目で設定するようになりました。   

- `timeout`(廃止): 起動/シャットダウン待ちのタイムアウト設定が廃止されました。  
v2では代わりに各リソースで[timeoutsブロック](https://www.terraform.io/docs/configuration/resources.html#operation-timeouts)が指定可能となりました。  
各リソース/各操作のデフォルトタイムアウトについては各リソースのドキュメントを参照してください。

- `zones`(追加): 利用可能なゾーンをリストで指定可能になりました。  
例えば石狩第1と石狩第2のみを利用したい場合、`zones = ["is1a", "is1b"]`と指定します。  

- `fake_mode`/`fake_store_path`(追加): 開発者向けにさくらのクラウドAPI呼び出しをシミュレーションするfakeモードという機能が追加されました。  

---

## データソースの変更点 {: #diffDetailDataSource }

### [ブリッジ: `sakuracloud_bridge`](https://docs.usacloud.jp/terraform/d/bridge) {: #dataSourceBridge}

- `switch_ids`(廃止) 

---

### [データベース: `sakuracloud_database`](https://docs.usacloud.jp/terraform/d/database) {: #dataSourceDatabase}

- `backup`(追加)
    - `backup_time`(名称変更) => `time`
    - `backup_weekdays`(名称変更) => `weekdays`
- `database_type`(追加) => データベース種別(MariaDB or PostgreSQL)
- `user_name`(名称変更) => `username`
- `user_password`(名称変更) => `password`
- `network_interface`(追加)
    - `allow_networks`(名称変更) => `source_ranges`  
    - `default_route`(名称変更) => `gateway`
    - `ipaddress1`(名称変更) => `ip_address`
    - `nw_mask_len`(名称変更) => `netmask`
    - `port`(移動)
    - `switch_id`

---

### [ディスク: `sakuracloud_disk`](https://docs.usacloud.jp/terraform/d/disk) {: #dataSourceDisk}

- `source_archive_id`(追加)
- `source_disk_id`(追加)

---

### [DNS: `sakuracloud_dns`](https://docs.usacloud.jp/terraform/d/dns) {: #dataSourceDNS}

- `record`(追加) => レコード

---

### [GSLB: `sakuracloud_gslb`](https://docs.usacloud.jp/terraform/d/gslb) {: #dataSourceGSLB}

- `server`(追加) => 実サーバ

---

### [アイコン: `sakuracloud_icon`](https://docs.usacloud.jp/terraform/d/icon) {: #dataSourceIcon}

- `body`(廃止) 

---

### [スイッチ+ルータ: `sakuracloud_internet`](https://docs.usacloud.jp/terraform/d/internet) {: #dataSourceInternet}

- `ipaddresses`(名称変更) => `ip_addresses`
- `ipv6_nw_address`(名称変更) => `ipv6_network_address`
- `max_ipaddress`(名称変更) => `max_ip_address`
- `min_ipaddress`(名称変更) => `min_ip_address`
- `nw_address`(名称変更) => `network_address`
- `nw_mask_len`(名称変更) => `netmask`

---

### [ロードバランサ: `sakuracloud_load_balancer`](https://docs.usacloud.jp/terraform/d/load_balancer) {: #dataSourceLocaBalancer}

- `vip`(追加) => 仮想IPアドレス(配下の実サーバを含む)
- `is_double`(廃止)
- `high_availability`(廃止)
- `network_interface`(追加)
    - `default_route`(名称変更) => `gateway`
    - `ipaddress1`/`ipaddress2`(統合) => `ip_addresses`(リスト)
    - `nw_mask_len`(名称変更) => `netmask`
    - `switch_id`(移動)
    - `vrid`(移動)

---

### [NFS: `sakuracloud_nfs`](https://docs.usacloud.jp/terraform/d/nfs) {: #dataSourceNFS}

- `network_interface`(追加)
    - `gateway`(移動)
    - `ipaddress`(名称変更) => `ip_address`
    - `nw_mask_len`(名称変更) => `netmask`
    - `switch_id`(移動)

---

### [パケットフィルタ : `sakuracloud_packet_filter`](https://docs.usacloud.jp/terraform/d/packet_filter) {: #dataSourcePacketFilter}

- `expressions`(名称変更) => `expression`
    - `dest_port`(名称変更) => `destination_port`
    - `source_nw`(名称変更) => `source_network`

---

### [専有ホスト: `sakuracloud_private_host`](https://docs.usacloud.jp/terraform/d/private_host) {: #dataSourcePrivateHost}

- `class`(追加) => 種別(標準/Windows)
- `icon_id`(追加) => アイコンID

---

### [エンハンスドロードバランサ: `sakuracloud_proxylb`](https://docs.usacloud.jp/terraform/d/proxylb) {: #dataSourceProxyLB}

- `bind_ports`(名称変更) => `bind_port`
- `certificate`
    - `additional_certificates`(名称変更) => `additional_certificate`
- `region`(追加) => 設置リージョン
- `rule` => 振り分けルール
- `servers`(名称変更) => `server`
    - `group`(追加) => 振り分け先グループ名
    - `ipaddress`(名称変更) => `ip_address`
- `sorry_server`
    - `ipaddress`(名称変更) => `ip_address`

---

### [サーバ: `sakuracloud_server`](https://docs.usacloud.jp/terraform/d/server) {: #dataSourceServer}

- `display_ipaddress`/`additional_display_ipaddresses`(移動/名称変更) => `network_interface`ブロック内へ移動、`user_ip_address`へ名称変更
- `nic`/`additional_nics`(統合/変更) => `network_interface`に統合
- `gateway`(挙動変更) => `gateway`(読み取り専用)
- `hostname`(挙動変更) => `hostname`(読み取り専用)
- `ipaddress`(名称変更/挙動変更) => `ip_address`(読み取り専用)
- `macaddresses`(名称変更/移動) => `network_interface`ブロック内へ移動、`mac_address`へ名称変更
- `nw_address`(名称変更) => `network_address`
- `nw_mask_len`(名称変更) => `netmask`(読み取り専用)
- `packet_filter_ids` => `network_interface`ブロック内へ移動、`packet_filter_id`へ名称変更
- `vnc_host`/`vnc_password`/`vnc_port`(廃止) => 代わりに`sakuracloud_server_vnc_info`データソースが利用可能

---

### [シンプル監視: `sakuracloud_simple_monitor`](https://docs.usacloud.jp/terraform/d/simple_monitor) {: #dataSourceSimpleMonitor }

- `health_check`
    - `delay_loop`(移動) => トップレベルへ移動
    - `status`(データ型変更) => 文字列から数値型へ変更
- `notify_interval`(単位変更) => 秒単位で指定から時間単位で指定するように変更    

---

### [サブネット: `sakuracloud_subnet`](https://docs.usacloud.jp/terraform/d/subnet) {: #dataSourceSubnet }

- `ipaddresses`(名称変更) => `ip_addresses`
- `ipv6_nw_address`(名称変更) => `ipv6_network_address`
- `max_ipaddress`(名称変更) => `max_ip_address`
- `min_ipaddress`(名称変更) => `min_ip_address`
- `nw_address`(名称変更) => `network_address`
- `nw_mask_len`(名称変更) => `netmask`

---

### [VPCルータ: `sakuracloud_vpc_router`](https://docs.usacloud.jp/terraform/d/vpc_router) {: #dataSourceVPCRouter}

- `dhcp_server`
    - `vpc_router_interface_index`(名称変更) => `interface_index`
- `dhcp_static_mapping`
    - `ipaddress`(名称変更) => `ip_address`
    - `macaddress`(名称変更) => `mac_address`
- `firewall`
    - `expressions`(名称変更) => `expression`
        - `dest_nw`(名称変更) => `destination_network`
        - `dest_port`(名称変更) => `destination_port`
        - `source_nw`(名称変更) => `source_network`
    - `vpc_router_interface_index`(名称変更) => `interface_index`
- `global_address`(名称変更) => `public_ip`
- `interface`(名称変更) => `private_network_interface`
    - `nw_mask_len`(名称変更) => `netmask`
- `public_network_interface`(追加)
    - `aliases`(移動)
    - `ipaddress1`/`ipaddress2`(移動/統合) => `ip_addresses`(リスト)
    - `switch_id`(移動)
    - `vip`(移動)
    - `vrid`(移動)
- `public_netmask`(追加)
- `port_forwarding`
    - `private_address`(名称変更) => `private_ip`
    - `global_port`(名称変更) => `public_port`
- `site_to_site_vpn`
    - `esp_authentication_protocol`(廃止)
    - `esp_dh_group`(廃止)
    - `esp_encryption_protocol`(廃止)
    - `esp_lifetime`(廃止)
    - `esp_mode`(廃止)
    - `esp_perfect_forward_secrecy`(廃止)
    - `ike_authentication_protocol`(廃止)
    - `ike_encryption_protocol`(廃止)
    - `ike_lifetime`(廃止)
    - `ike_mode`(廃止)
    - `ike_perfect_forward_secrecy`(廃止)
    - `ike_pre_shared_secret`(廃止)
    - `peer_id`(廃止)
    - `peer_inside_networks`(廃止)
    - `peer_outside_ipaddress`(廃止)
    - `vpc_router_inside_networks`(廃止)
    - `vpc_router_outside_ipaddress`(廃止)
- `static_nat`
    - `global_address`(名称変更) => `public_ip`
    - `private_address`(名称変更) => `private_ip`

### ウェブアクセラレータ: `sakuracloud_webaccel` {: #dataSourceWebAccel}

v2時点では未実装(近日実装予定)


## リソースの変更点 {: #diffDetailResource }

### [ブリッジ: `sakuracloud_bridge`](https://docs.usacloud.jp/terraform/r/bridge) {: #resourceBridge }

- `switch_ids`(廃止)

---

### [データベース: `sakuracloud_database`](https://docs.usacloud.jp/terraform/r/database) {: #resourceDatabase }

- `backup`(追加)
    - `backup_time`(名称変更) => `time`
    - `backup_weekdays`(名称変更) => `weekdays`
- `graceful_shutdown_timeout`(廃止)
- `network_interface`(追加)
    - `allow_networks`(名称変更) => `source_ranges`  
    - `default_route`(名称変更) => `gateway`
    - `ipaddress1`(名称変更) => `ip_address`
    - `nw_mask_len`(名称変更) => `netmask`
    - `port`(移動)
    - `switch_id`(移動)
- `replica_user`(挙動変更) => 読み取り専用から書き込み可能に
- `user_name`(名称変更) => `username`
- `user_password`(名称変更) => `password`

---

### [データベース(リードレプリカ): `sakuracloud_database_read_replica`](https://docs.usacloud.jp/terraform/r/database_read_replica) {: #resourceDatabaseReadReplica }

- `graceful_shutdown_timeout`(廃止)
- `network_interface`(追加)
    - `source_ranges`(追加)  
    - `default_route`(名称変更) => `gateway`
    - `ipaddress1`(名称変更) => `ip_address`
    - `nw_mask_len`(名称変更) => `netmask`
    - `port`(移動)
    - `switch_id`(移動)
- `replica_user`(挙動変更) => 読み取り専用から書き込み可能に
- `replica_user`(挙動変更) => 読み取り専用から書き込み可能に

---

### [ディスク: `sakuracloud_disk`](https://docs.usacloud.jp/terraform/r/disk) {: #resourceDisk }

- `disable_pw_auth`(廃止)
- `graceful_shutdown_timeout`(廃止)
- `hostname`(廃止)
- `note_ids`(廃止)
- `password`(廃止)
- `ssh_key_ids`(廃止)

!!! Note
    ディスクの修正関連のパラメータが廃止されました。  
    代わりに`sakuracloud_server`の`disk_edit_parameter`ブロックを利用してください。  

---

### [DNS: `sakuracloud_dns`](https://docs.usacloud.jp/terraform/r/dns) {: #resourceDNS }

- `records`(名称変更) => `record`

---

### [GSLB: `sakuracloud_gslb`](https://docs.usacloud.jp/terraform/r/gslb) {: #resourceGSLB }

- `servers`(名称変更) => `server`
    - `ipaddress`(名称変更) => `ip_address`

---

### [アイコン: `sakuracloud_icon`](https://docs.usacloud.jp/terraform/r/icon) {: #resourceIcon }

- `body`(廃止)

---

### [スイッチ+ルータ: `sakuracloud_internet`](https://docs.usacloud.jp/terraform/r/internet) {: #resourceInternet }

- `graceful_shutdown_timeout`(廃止)
- `ipaddresses`(名称変更) => `ip_addresses`
- `ipv6_nw_address`(名称変更) => `ipv6_network_address`
- `max_ipaddress`(名称変更) => `max_ip_address`
- `min_ipaddress`(名称変更) => `min_ip_address`
- `nw_address`(名称変更) => `network_address`
- `nw_mask_len`(名称変更) => `netmask`

---

### [IPv4逆引きレコード: `sakuracloud_ipv4_ptr`](https://docs.usacloud.jp/terraform/r/ipv4_ptr) {: #resourceIPv4PTR }

- `ipaddress`(名称変更) => `ip_address`

### [ロードバランサ: `sakuracloud_load_balancer`](https://docs.usacloud.jp/terraform/r/load_balancer) {: #resourceLoadBalancer }

- `default_route`(名称変更) => `gateway`
- `graceful_shutdown_timeout`(廃止)
- `is_double`(廃止)
- `high_availability`(廃止)
- `network_interface`(追加)
    - `default_route`(名称変更) => `gateway`
    - `ipaddress1`/`ipaddress2`(統合) => `ip_addresses`(リスト)
    - `nw_mask_len`(名称変更) => `netmask`
    - `switch_id`(移動)
    - `vrid`(移動)
- `vip_ids`(廃止)
- `vips`(名称変更) => `vip`
    - `servers`(名称変更) => `server`
        - `check_path`(名称変更) => `path`
        - `check_protocol`(名称変更) => `protocol`
        - `check_status`(名称変更) => `status`
        - `ipaddress`(名称変更) => `ip_address`

---

### [モバイルゲートウェイ : `sakuracloud_mobile_gateway`](https://docs.usacloud.jp/terraform/r/mobile_gateway) {: #resourceMobileGateway }

- `dns_server1`/`dns_server2`(統合) => `dns_servers`(リスト)
- `graceful_shutdown_timeout`(廃止)
- `inter_device_communication`(追加)
- `private_ipaddress`/`private_nw_mask_len`/`switch_id`(統合) => `private_network_interface`(ブロック)
- `sim_ids`(廃止)
- `sim`(追加)
- `sim_route`(追加)
    
---

### [NFS: `sakuracloud_nfs`](https://docs.usacloud.jp/terraform/r/nfs) {: #resourceNFS }

- `network_interface`(追加)
    - `gateway`(移動)
    - `ipaddress`(名称変更) => `ip_address`
    - `nw_mask_len`(名称変更) => `netmask`
    - `switch_id`(移動)


---

### [パケットフィルタ : `sakuracloud_packet_filter`](https://docs.usacloud.jp/terraform/r/packet_filter) {: #resourcePacketFilter }

- `expressions`(名称変更) => `expression`
    - `dest_port`(名称変更) => `dest_port`
    - `source_nw`(名称変更) => `source_network`
    
---

### [パケットフィルタ (ルール): `sakuracloud_packet_filter_rule`](https://docs.usacloud.jp/terraform/r/packet_filter_rules) {: #resourcePacketFilterRule }

v1では1つのパケットフィルタ内の1つのルールを表すリソースとして`sakuracloud_packet_filter_rule`がありましたが、
v2ではルール全体を表す`sakuracloud_packet_filter_rules`に変更されました。

ドキュメント: [sakuracloud_packet_filter_rules](https://docs.usacloud.jp/terraform/r/packet_filter_rules)

---

### [専有ホスト: `sakuracloud_private_host`](https://docs.usacloud.jp/terraform/r/private_host) {: #resourcePrivateHost }

- `class`(追加) => 種別(標準/Windows)を表す項目を追加
- `graceful_shutdown_timeout`(廃止)

---

### [エンハンスドロードバランサ: `sakuracloud_proxylb`](https://docs.usacloud.jp/terraform/r/proxylb) {: #resourceProxyLB }

- `region`(追加) => 設置先リージョン
- `bind_ports`(名称変更) => `bind_port`
- `certificate`
    - `additional_certificates`(名称変更) => `additional_certificate`
- `health_check`
    - `port`(追加)
- `rule`(追加) => 振り分けルール
- `servers`(名称変更) => `server`
    - `ipaddress`(名称変更) => `ip_address`
    - `group`(追加) => 振り分け先グループ名
- `sorry_server`
    - `ipaddress`(名称変更) => `ip_address`

---

### [エンハンスドロードバランサ(ACME): `sakuracloud_proxylb_acme`](https://docs.usacloud.jp/terraform/r/proxylb_acme) {: #resourceProxyLBACME }

- `certificate`
    - `additional_certificates`(名称変更) => `additional_certificate`

---

### [サーバ: `sakuracloud_server`](https://docs.usacloud.jp/terraform/r/server) {: #resourceServer }

- `display_ipaddress`/`additional_display_ipaddresses`(移動/名称変更) => `network_interface`ブロック内へ移動、`user_ip_address`へ名称変更
- `nic`/`additional_nics`(統合/変更) => `network_interface`に統合
- `disk_edit_parameter`(追加) => ディスクの修正関連パラメータ
- `force_shutdown`(追加) => シャットダウン/リブートの際に強制終了するかのフラグ
- `graceful_shutdown_timeout`(廃止)
- `gateway`(挙動変更) => `gateway`(読み取り専用)
- `hostname`(挙動変更) => `hostname`(読み取り専用)
- `ipaddress`(名称変更/挙動変更) => `ip_address`(読み取り専用)
- `macaddresses`(名称変更/移動) => `network_interface`ブロック内へ移動、`mac_address`へ名称変更
- `nw_address`(名称変更) => `network_address`
- `nw_mask_len`(名称変更) => `netmask`(読み取り専用)
- `packet_filter_ids` => `network_interface`ブロック内へ移動、`packet_filter_id`へ名称変更
- `vnc_host`/`vnc_password`/`vnc_port`(廃止) => 代わりに`sakuracloud_server_vnc_info`データソースが利用可能

#### ネットワークインターフェース設定の変更

!!! Note
    これまで`nic`と`additional_nics`で設定していたネットワークインターフェース(NIC)は`network_interface`で指定するように変更されました。  
    これに伴い、`nic`を省略した場合の挙動が変更されました。
      
    旧: 共有セグメントに接続  
    新: NICなし  
      
    v2でのNIC設定は明示的に`network_interface`を記載する必要があります。

##### v2でのnetwork_interfaceの設定例:

```tf
resource "sakuracloud_server" "example" {
  name        = "foobar"
  disks       = [sakuracloud_disk.foobar.id]
  description = "description"
  tags        = ["tag1", "tag2"]

  # eth0
  network_interface {
    upstream         = "shared"
    packet_filter_id = data.sakuracloud_packet_filter.foobar.id
  }
  # eth1
  network_interface {
    upstream         = "123456789012" # スイッチのID
    packet_filter_id = data.sakuracloud_packet_filter.foobar.id
  }

  disk_edit_parameter {
    hostname        = "hostname"
    password        = "password"
    disable_pw_auth = true
  }
}
```

---

### [SIM: `sakuracloud_sim`](https://docs.usacloud.jp/terraform/r/sim) {: #resourceSIM }

- `ipaddress`(名称変更/挙動変更) => `ip_address`(読み取り専用)
- `mobile_gateway_id`(挙動変更) => 読み取り専用へ変更

!!! Note
    モバイルゲートウェイに接続するには`sakuracloud_mobile_gateway`の`sim`ブロックを設定するように変更されました。

---

### [シンプル監視: `sakuracloud_simple_monitor`](https://docs.usacloud.jp/terraform/r/simple_monitor) {: #resourceSimpleMonitor }

- `health_check`
    - `delay_loop`(移動) => トップレベルへ移動
    - `status`(データ型変更) => 文字列から数値型へ変更
- `notify_interval`(単位変更) => 秒単位で指定から時間単位で指定するように変更    

---

### [サブネット: `sakuracloud_subnet`](https://docs.usacloud.jp/terraform/r/subnet) {: #resourceSubnet }

- `ipaddresses`(名称変更) => `ip_addresses`
- `ipv6_nw_address`(名称変更) => `ipv6_network_address`
- `max_ipaddress`(名称変更) => `max_ip_address`
- `min_ipaddress`(名称変更) => `min_ip_address`
- `nw_address`(名称変更) => `network_address`
- `nw_mask_len`(名称変更) => `netmask`

---

### [スイッチ: `sakuracloud_switch`](https://docs.usacloud.jp/terraform/r/switch) {: #resourceSwitch }

- `graceful_shutdown_timeout`(廃止)

---

### [VPCルータ: `sakuracloud_vpc_router`](https://docs.usacloud.jp/terraform/r/vpc_router) {: #resourceVPCRouter }

- `dhcp_server`
    - `vpc_router_interface_index`(名称変更) => `interface_index`
- `dhcp_static_mapping`
    - `ipaddress`(名称変更) => `ip_address`
    - `macaddress`(名称変更) => `mac_address`
- `firewall`
    - `expressions`(名称変更) => `expression`
        - `dest_nw`(名称変更) => `destination_network`
        - `dest_port`(名称変更) => `destination_port`
        - `source_nw`(名称変更) => `source_network`
    - `vpc_router_interface_index`(名称変更) => `interface_index`
- `global_address`(名称変更) => `public_ip`
- `graceful_shutdown_timeout`(廃止)
- `interface`(名称変更) => `private_network_interface`
    - `nw_mask_len`(名称変更) => `netmask`
- `public_network_interface`(追加)
    - `aliases`(移動)
    - `ipaddress1`/`ipaddress2`(移動/統合) => `ip_addresses`(リスト)
    - `switch_id`(移動)
    - `vip`(移動)
    - `vrid`(移動)
- `public_netmask`(追加)
- `port_forwarding`
    - `private_address`(名称変更) => `private_ip`
    - `global_port`(名称変更) => `public_port`
- `site_to_site_vpn`
    - `esp_authentication_protocol`(廃止)
    - `esp_dh_group`(廃止)
    - `esp_encryption_protocol`(廃止)
    - `esp_lifetime`(廃止)
    - `esp_mode`(廃止)
    - `esp_perfect_forward_secrecy`(廃止)
    - `ike_authentication_protocol`(廃止)
    - `ike_encryption_protocol`(廃止)
    - `ike_lifetime`(廃止)
    - `ike_mode`(廃止)
    - `ike_perfect_forward_secrecy`(廃止)
    - `ike_pre_shared_secret`(廃止)
    - `peer_id`(廃止)
    - `peer_inside_networks`(廃止)
    - `peer_outside_ipaddress`(廃止)
    - `vpc_router_inside_networks`(廃止)
    - `vpc_router_outside_ipaddress`(廃止)
- `static_nat`
    - `global_address`(名称変更) => `public_ip`
    - `private_address`(名称変更) => `private_ip`
---


