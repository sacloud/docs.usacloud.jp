# Examples: LB + サーバの水平スケール

## 概要

LB配下のサーバの水平スケール(台数変更)を行います。  
LB配下に指定したサーバグループの台数の増減に合わせLBの実サーバとして登録/削除されます。

!!! warning
    LB+サーバの水平スケールは無停止/サービス中断なしで行えますが、実サーバが1台以上必要です。  

## 構成例

以下の条件でサーバを水平スケールさせる例です。

- 対象エンハンスドロードバランサ:
    - example
- 対象サーバグループ:
    - is1aゾーンの`servers`グループ
    - 2コア/4GBメモリ
    - eth0は共有セグメント(100Mbps)に接続
    - eth1をスイッチ(名前:`example`)に接続  
    - eth1の80番ポートをLBのVIP`192.168.0.1`配下の実サーバのアドレスとして登録
    - eth1のIPアドレスを`192.168.0.33`から順次割り当て

```yaml
resources:
  - type: ServerGroup
    name: "servers"
    
    server_name_prefix: "servers"
    zone: "is1a"
    
    parent:
      type: LoadBalancer
      selector: "example"

    min_size: 5   # 最小インスタンス数
    max_size: 20  # 最大インスタンス数
    
    template: # 各サーバのテンプレート
      plan:
        core: 2
        memory: 4

      # NICs
      network_interfaces:
        # eth0
        - upstream: "shared"
            
        # eth1    
        - upstream:
            names: ["example"]
          assign_cidr_block: "192.168.0.32/27" #.33から順に割り当てられる
          assign_netmask_len: 24
          expose:
            ports: [ 80 ] # このNICで上流リソースに公開するポート番号
       
            # LB向け
            vips: [ "192.168.0.1" ] 
            health_check:
              protocol: http
              path: "/"
              status_code: 200
       
      # ディスク
      disks:
        - os_type: "ubuntu2004"
          plan: "ssd"
          connection: "virtio"
          size: 40

      # 1番目のディスクの対するパラメータ(対応しているアーカイブの場合のみ指定可能)
      edit_parameter:
        disabled: false # ディスクの修正を行わない場合はtrue
        password: "your-password"
        disable_pw_auth: true
        enable_dhcp: false
        change_partition_uuid: true

        # SSH公開鍵の指定
        ssh_keys:
          # ファイルパス or 文字列で指定
          - "~/.ssh/id_rsa.pub"

        # スタートアップスクリプト
        # サーバのIPアドレス(共有セグメントの場合の自動割り当て)などを{{ .IPAddress}}のようなGoのテンプレートで利用可能
        startup_scripts:
          - "/my/path/provisioning.sh"
```

スタートアップスクリプトとして以下を指定しています。(`/my/path/provisioning.sh`)
```bash
#!/bin/bash

# @sacloud-once

# eth1へのIPアドレス設定
cat <<EOL >> /etc/netplan/99-eth1-netcfg.yaml
network:
  ethernets:
    eth1:
      addresses:
        - {{ with index .NetworkInterfaces 1 }}{{ with .AssignedNetwork }}{{ .IpAddress }}/{{ .Netmask }}{{ end }}{{ end }}
      dhcp4: 'no'
      dhcp6: 'no'
EOL

# ループバックインターフェースへのVIPアドレス設定
cat <<EOL >> /etc/netplan/99-lo-netcfg.yaml
network:
  ethernets:
    lo:
      addresses:
        - 192.168.0.1/32
EOL

# バーチャルサーバー宛のARPに応答しないようにする
cat <<EOL >> /etc/sysctl.conf
net.ipv4.conf.all.arp_ignore = 1
net.ipv4.conf.all.arp_announce = 2
EOL

# 反映
sysctl -p
netplan apply

# NGINXのインストール
apt update; apt install -y nginx
```

!!! info
リソース定義が1つだけなため、Inputsからのリクエスト時に`resource-name`パラメータを省略可能です。

    例:  
    Webhook系のリクエストURL例: `http://<your-host>/up`  
    Direct Inputsの実行例: `autoscaler inputs direct up`  

