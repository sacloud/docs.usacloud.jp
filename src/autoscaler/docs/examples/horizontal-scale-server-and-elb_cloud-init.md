# Examples: ELB + サーバの水平スケール(cloud-init)

## 概要

ELB配下のサーバの水平スケール(台数変更)を行います。  
ELB配下に指定したサーバグループの台数の増減に合わせELBの実サーバとして登録/削除されます。

!!! warning
    ELB+サーバの水平スケールは無停止/サービス中断なしで行えますが、実サーバが1台以上必要です。  

## 構成例

以下の条件でサーバを水平スケールさせる例です。

- 対象エンハンスドロードバランサ:
    - example
- 対象サーバグループ:
    - is1aゾーンの`servers`グループ
    - 2コア/4GBメモリ
    - インターネット側のNICとして共有セグメント(100Mbps)を利用
    - eth0の80番ポートをELBの実サーバのアドレスとして登録
    - サーバのプロビジョニングにはcloud-initを利用

```yaml
resources:
  - type: ServerGroup
    name: "servers"
    
    server_name_prefix: "servers"
    zone: "is1a"
    
    parent:
      type: ELB
      selector: "example"

    min_size: 5   # 最小インスタンス数
    max_size: 20  # 最大インスタンス数

    auto_healing:
      enabled: true #台数維持機能の有効化    

    template: # 各サーバのテンプレート
      plan:
        core: 2
        memory: 4

      # NICs
      network_interfaces:
        - upstream: "shared"
          expose:
            ports: [ 80 ] # このNICで上流リソースに公開するポート番号

      # ディスク
      disks:
        - source_archive:
            names: ["Ubuntu", "20.04", "cloudimg"]
          plan: "ssd"
          connection: "virtio"
          size: 20

      cloud_config: |
        #cloud-config
        chpasswd:
          expire: false
        hostname: example
        locale: ja_JP.utf8
        package_update: true
        packages:
          - nginx
        ssh_authorized_keys:
          - "ssh-rsa ..." #公開鍵
        ssh_pwauth: false
        timezone: "Asia/Tokyo"
        
    
    
```

!!! info
リソース定義が1つだけなため、Inputsからのリクエスト時に`resource-name`パラメータを省略可能です。

    例:  
    Webhook系のリクエストURL例: `http://<your-host>/up`  
    Direct Inputsの実行例: `autoscaler inputs direct up`  

