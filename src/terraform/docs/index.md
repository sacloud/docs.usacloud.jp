# Terraform for さくらのクラウド(v2)

---

## 概要

`Terraform for さくらのクラウド`とは、
[Terraform](https://terraform.io)から[さくらのクラウド](http://cloud.sakura.ad.jp)を操作するためのTerraform用プラグインです。  

!!! Note
    このドキュメントはterraform-provider-sakuracloud v2を対象としています。  
    v1をご利用の場合は以下のドキュメントを参照してください。  
      
    [Terraform for さくらのクラウド(v1)](https://docs.usacloud.jp/terraform-v1/)
    
!!! Note
    このドキュメントはterraform-provider-sakuracloudの英語版ドキュメントを元に翻訳/加筆したものです。  
    最新のドキュメントはterraform-provider-sakuracloudのリポジトリの`website`ディレクトリを参照してください。
      
    [https://github.com/sacloud/terraform-provider-sakuracloud/](https://github.com/sacloud/terraform-provider-sakuracloud/)

## 目次

#### アップグレードガイド:

- [v2.0での変更点](guides/upgrade_to_v2.0.0)
- [v2.1での変更点](guides/upgrade_to_v2.1.0)

#### 設定リファレンス:
- [プロバイダ設定](provider/)
- プロバイダデータソース
    - [ゾーン](d/zone)
- コンピュート
    - データソース
        - [専有ホスト](d/private_host)
        - [サーバ](d/server)
        - [VNC接続情報](d/server_vnc_info)
    - リソース
        - [専有ホスト](r/private_host)
        - [サーバ](r/server)
- ストレージ
    - データソース
        - [アーカイブ](d/archive)
        - [CD-ROM](d/cdrom)
        - [ディスク](d/disk)
    - リソース
        - [アーカイブ](r/archive)
        - [CD-ROM](r/cdrom)
        - [ディスク](r/disk)
- ネットワーク
    - データソース
        - [ブリッジ](d/bridge)
        - [スイッチ+ルータ](d/internet)
        - [ローカルルータ](d/local_router)
        - [パケットフィルタ](d/packet_filter)
        - [サブネット](d/subnet)
        - [スイッチ](d/switch)
    - リソース
        - [ブリッジ](r/bridge)
        - [スイッチ+ルータ](r/internet)
        - [IPv4逆引き](r/ipv4_ptr)
        - [ローカルルータ](r/local_router)
        - [パケットフィルタ](r/packet_filter)
        - [パケットフィルタ(ルール)](r/packet_filter_rules)
        - [サブネット](r/subnet)
        - [スイッチ](r/switch)
- アプライアンス
    - データソース
        - [データベース](d/database)
        - [ロードバランサ](d/load_balancer)
        - [NFS](d/nfs)
        - [VPCルータ](d/vpc_router)
    - リソース
        - [自動バックアップ](r/auto_backup)
        - [データベース](r/database)
        - [データベース(リードレプリカ)](r/database_read_replica)
        - [ロードバランサ](r/load_balancer)
        - [NFS](r/nfs)
        - [VPCルータ](r/vpc_router)
- グローバル
    - データソース
        - [DNS](d/dns)
        - [GSLB](d/gslb)
        - [エンハンスドロードバランサ](d/proxylb)
        - [シンプル監視](d/simple_monitor)
    - リソース
        - [DNS](r/dns)
        - [DNSレコード](r/dns_record)
        - [GSLB](r/gslb)
        - [エンハンスドロードバランサ](r/proxylb)
        - [エンハンスドロードバランサ(ACME設定)](r/proxylb_acme)
        - [シンプル監視](r/simple_monitor)
- セキュアモバイル
    - リソース
        - [モバイルゲートウェイ ](r/mobile_gateway)
        - [SIM](r/sim)
- Lab
    - データソース
        - [コンテナレジストリ](d/container_registry)
    - リソース
        - [コンテナレジストリ](r/container_registry)
- その他
    - データソース
        - [アイコン](d/icon)
        - [スタートアップスクリプト](d/note)
        - [SSH公開鍵](d/ssh_key)
    - リソース
        - [アイコン](r/icon)
        - [スタートアップスクリプト](r/note)
        - [SSH公開鍵](r/ssh_key)
        - [SSH公開鍵生成](r/ssh_key_gen)
- オブジェクトストレージ
    - データソース
        - [バケットオブジェクト](d/bucket_object)
    - リソース
        - [バケットオブジェクト](r/bucket_object)

