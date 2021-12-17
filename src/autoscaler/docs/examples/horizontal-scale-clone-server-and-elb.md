# Examples: ELB + サーバの水平スケール(クローン)

## 概要

ELB配下のサーバの水平スケール(台数変更)を行います。  
水平スケール対象のサーバは指定のサーバをクローン(ディスクのクローン)として作成します。  
ELB配下に指定したサーバグループの台数の増減に合わせELBの実サーバとして登録/削除されます。


## 構成例

以下の条件でサーバを水平スケールさせる例です。

- 対象エンハンスドロードバランサ:
    - example
- 対象サーバグループ:
    - is1aゾーンの`servers`グループ
    - 2コア/4GBメモリ
    - インターネット側のNICとして共有セグメント(100Mbps)を利用
    - eth0の80番ポートをELBの実サーバのアドレスとして登録
    - ディスクソースとしてクローン元のサーバのディスクを指定

サーバのプロビジョニングはクローン元のサーバに対してあらかじめ行っておく必要があります。

```yaml
resources:
  - type: ELB
    name: "elb"
    selector:
      names: ["example"]
    resources:
      - type: ServerGroup
        name: "servers"
        zone: "is1a"
    
        min_size: 5   # 最小インスタンス数
        max_size: 20  # 最大インスタンス数
        
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
            - names: ["clone-source-disk"] #クローン元サーバのディスクの名前
              
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
```

!!! Info
    リソースが複数存在するため、Inputsからのリクエスト時に`resource-name`パラメータを指定する必要があります。  
    
    例:  
    Webhook系のリクエストURL例: `http://<your-host>/up?resource-name=servers`  
    Direct Inputsの実行例: `autoscaler inputs direct up --resource-name servers`  

!!! tips
    ELBリソースをスケールアップ/ダウンしたい場合は以下のように`resource-name`パラメータを指定します。   
    `autoscaler inputs direct up --resource-name elb`  
