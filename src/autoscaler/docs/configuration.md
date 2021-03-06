# Configuration Reference

sacloud/autoscalerのコンフィギュレーションファイルはYAML形式で書かれた、操作対象のリソース定義や動作を調整するためのものです。  

## コンフィギュレーションファイルの例:

```yaml
# 操作対象のリソースの定義
# スケールさせたいリソース群をここで定義する
resources:
  # GSLB(配下のサーバが垂直スケールする際にサーバのデタッチ&アタッチが行われる)
  - type: GSLB
    name: "gslb"
    selector:
      names: ["example-gslb"]
    resources:
      # サーバ(垂直スケール)
      - type: Server
        naem: "server"
        selector:
          names: ["example"]
          zones: ["is1a"]
        shutdown_force: true

# カスタムハンドラーの定義
# handlers:
#   - name: "fake"
#     endpoint: "unix:autoscaler-handlers-fake.sock"

# オートスケーラーの動作設定
autoscaler:
  cooldown: 600 

# さくらのクラウド API関連
# sakuracloud:
#   token: "<your-token>"
#   secret: "<your-secret>"
```

## スキーマ

- [&lt;top_level&gt;](#top_level)
  - [&lt;resource_definition&gt;](#resource_definition) 
    - [&lt;resource_def_dns&gt;](#resource_def_dns)
    - [&lt;resource_def_elb&gt;](#resource_def_elb)
    - [&lt;resource_def_gslb&gt;](#resource_def_gslb)
    - [&lt;resource_def_load_balancer&gt;](#resource_def_load_balancer)
    - [&lt;resource_def_router&gt;](#resource_def_router)
    - [&lt;resource_def_server&gt;](#resource_def_server)
    - [&lt;resource_def_server_group&gt;](#resource_def_server_group)
  - [&lt;handler&gt;](#handler)
  - [&lt;autoscaler_config&gt;](#autoscaler_config)

### &lt;top_level&gt;

```yaml
# オートスケール対象リソースの定義
resources:
        [ - <resource_definition> ]

# カスタムハンドラーのリスト(省略可能)
handlers:
        [ - <handler> ]

# オートスケーラーの動作設定(省略可能)
autoscaler:
  <autoscaler_config>

# さくらのクラウドAPI関連設定(省略可能)
# Note: APIキーにはアクセスレベル`作成・削除`または`設定編集`が必要です
sakuracloud:
  # APIトークン、省略した場合は環境変数SAKURACLOUD_ACCESS_TOKENを参照します
  token: <string>
  # APIシークレット、省略した場合は環境変数SAKURACLOUD_ACCESS_TOKEN_SECRETを参照します
  secret:  <string>
```

### &lt;resource_definition&gt;

操作対象となるさくらのクラウド上のリソースの定義
resource_def_xxxのいずれかを指定します。

```yaml
<resource_def_dns> | <resource_def_elb> | <resource_def_gslb> | <resource_def_load_balancer> | <resource_def_router> | <resource_def_server> | <resource_def_server_group>
```

### &lt;resource_def_dns&gt;

DNSリソースの定義

```yaml
type: "DNS"
name: <string>
selector:
  # idかnamesのどちらかを指定、必須
  id: <string | number>
  # 部分一致、複数指定した場合はAND結合
  names: 
    [ - <string> ]

# 子リソースの定義(省略可能)
resources:
  [ - <resource_definition> ]
```

### &lt;resource_def_elb&gt;

エンハンスドロードバランサの定義。  
ここで定義したリソースは垂直スケール可能になります(ハンドラ`elb-vertical-scaler`)。  
また、`resources`配下に&lt;resource_def_server&gt;を定義し、かつELBの配信先サーバとIPアドレスが一致するサーバについては
水平スケールする前にELBからのデタッチ/アタッチが行われます(ハンドラ:`elb-servers-handler`)。

```yaml
type: "ELB" # or EnhancedLoadBalancer
name: <string>
selector:
  # idかnamesのどちらかを指定、必須
  id: <string | number>
  # 部分一致、複数指定した場合はAND結合
  names:
    [ - <string> ]
  # 垂直スケールさせる範囲(省略可能)
  plans:
    [ - name: <string> # プラン名、省略可能 
        cps: <number> ]
# 子リソースの定義(省略可能)
resources:
  [ - <resource_definition> ]
```

`plans`を省略した場合のデフォルト値は以下の通りです。

```yaml
# ELBのデフォルトの垂直スケール範囲
plans:
  - cps: 100
  - cps: 500
  - cps: 1000
  - cps: 5000
  - cps: 10000
  - cps: 50000
  - cps: 100000
  - cps: 400000
```

### &lt;resource_def_gslb&gt;

GSLBの定義。
`resources`配下に&lt;resource_def_server&gt;を定義し、かつGSLBの宛先サーバとIPアドレスが一致するサーバについては
水平スケールする前にGSLBからのデタッチ/アタッチが行われます(ハンドラ:`gslb-servers-handler`)。

```yaml
type: "GSLB"
name: <string>
selector:
  # idかnamesのどちらかを指定、必須
  id: <string | number>
  # 部分一致、複数指定した場合はAND結合
  names: 
    [ - <string> ]

# 子リソースの定義(省略可能)
resources:
  [ - <resource_definition> ]
```

### &lt;resource_def_load_balancer&gt;

ロードバランサの定義。
`resources`配下に&lt;resource_def_server&gt;を定義し、かつLBの宛先サーバとIPアドレスが一致するサーバについては
水平スケールする前にLBからのデタッチ/アタッチが行われます(ハンドラ:`load-balancer-servers-handler`)。

```yaml
type: "LoadBalancer"
name: <string>
selector:
  # idかnamesのどちらかを指定、必須
  id: <string | number>
  # 部分一致、複数指定した場合はAND結合
  names: 
    [ - <string> ]
  zones:
    [ - <"is1a" | "is1b" | "tk1a" | "tk1b" | "tk1v"> ]

# 子リソースの定義(省略可能)
resources:
  [ - <resource_definition> ]
```

### &lt;resource_def_router&gt;

ルータの定義。  
ここで定義したリソースは垂直スケール可能になります(ハンドラ`router-vertical-scaler`)。  

```yaml
type: "Router"
name: <string>
selector:
  # idかnamesのどちらかを指定、必須
  id: <string | number>
  # 部分一致、複数指定した場合はAND結合
  names:
    [ - <string> ]
  zones:
    [ - <"is1a" | "is1b" | "tk1a" | "tk1b" | "tk1v"> ]
  # 垂直スケールさせる範囲(省略可能)
  plans:
    [ - name: <string> # プラン名、省略可能 
        band_width: <number> ]
# 子リソースの定義(省略可能)
resources:
  [ - <resource_definition> ]
```

`plans`を省略した場合のデフォルト値は以下の通りです。

```yaml
# ルータのデフォルトの垂直スケール範囲
plans:
  - band_width: 100
  - band_width: 250
  - band_width: 500
  - band_width: 1000
  - band_width: 1500
  - band_width: 2000
  - band_width: 2500
  - band_width: 3000
  - band_width: 3500
  - band_width: 4000
  - band_width: 4500
  - band_width: 5000
```

### &lt;resource_def_server&gt;

サーバの定義。  
ここで定義したリソースは垂直スケール可能になります(ハンドラ`server-vertical-scaler`)。

```yaml
type: "Server"
name: <string>
selector:
  # idかnamesのどちらかを指定、必須
  id: <string | number>
  # 部分一致、複数指定した場合はAND結合
  names:
    [ - <string> ]
  zones:
    [ - <"is1a" | "is1b" | "tk1a" | "tk1b" | "tk1v"> ]
  
  # コア専有プランを利用するか
  dedicated_cpu: <boolean>
  
  # 強制シャットダウンを行うか(ACPIが利用できないサーバの場合trueにする)
  shutdown_force: <boolean> 
  
  # 垂直スケールさせる範囲(省略可能)
  plans:
    [ - name: <string> # プラン名、省略可能 
        core: <number> # コア数
        memory: <number> #メモリサイズ、GB単位 
    ]
  
# 子リソースの定義(省略可能)
resources:
  [ - <resource_definition> ]
```

`plans`を省略した場合のデフォルト値は以下の通りです。

```yaml
# サーバのデフォルトの垂直スケール範囲
plans:
  - core: 2
    memory: 4
  - core: 4
    memory: 8
  - core: 4
    memory: 16
  - core: 8
    memory: 16
  - core: 10
    memory: 24
  - core: 10
    memory: 32
  - core: 10
    memory: 48
```

### &lt;resource_def_server_group&gt;

サーバグループの定義。  
ここで定義したリソースは水平スケール可能になります(ハンドラ`server-horizontal-scaler`)。

```yaml
type: "ServerGroup"
name: <string> #グループ内の各サーバ名のプレフィックスとなる
zone: <"is1a" | "is1b" | "tk1a" | "tk1b" | "tk1v">
  
# 最小/最大サーバ数
min_size: <number>
max_size: <number>

# 名前付きプラン(サーバグループの場合はサーバ数をプランとして表す)
plans:
  [ - name: <string> # プラン名、省略可能 
      size: <number> # サーバ数
  ]

# 強制シャットダウンを行うか(ACPIが利用できないサーバの場合trueにする)
shutdown_force: <boolean>

# グループ内のサーバのテンプレート
template:
  tags: [ - <string> ] 
  description: <string>
  
  icon_id: <string>
  cdrom_id: <string>
  private_host_id: <string>

  interface_driver: <"virtio" | "e1000" | default="virtio">
  
  plan:
    core: <number>           # コア数
    memory: <number>         # メモリサイズ、GB単位 
    dedicated_cpu: <boolean> # コア専有の場合true
    
  # 接続するディスクをリストで指定  
  disks:
    [ - name_prefix: <string> # ディスク名のプレフィックス(省略可能)
        tags: [ - <string> ]
        description: <string>
        
        icon_id: <string>
        
        source_archive: <string> | <resource_selector>
        source_disk: <string> | <resource_selector>
        os_type: <string>
        
        plan: <"ssd" | "hdd">
        connection: <"virtio" | "ide">
        size: <number>
    ]
  
  edit_parameter:
    disabled: <boolean>        # ディスクの修正を行わない場合true
    host_name_prefix: <string> # ホスト名のプレフィックス(省略可能)
    password: <string>
    disable_pw_auth: <boolean>
    enable_dhcp: <boolean>
    change_partition_uuid: <boolean>
    startup_scripts: [ - <string> | <filepath> ]
    ssh_keys: [ - <string> | <filepath> ]
    ssh_key_ids: [ - <string> ]
    
  network_interfaces:
    # 上流ネットワーク
    upstream: <"shared"> | <resource_selector>
    
    # 以下はupstreamがsharedの場合のみ指定可能
    assign_cidr_block: <string>
    assign_netmask_len: <int>
    default_route: <string>
    packet_filter_id: <string>
    
    # 上流リソースの操作のためのメタデータ
    # サーバグループの上流にELB/GSLB/LB/DNSを定義している場合のみ指定可能
    expose:
      # 公開するポート番号のリスト
      ports: [ - <number> ] 
      
      # ELB向け: 実サーバ登録時のサーバグループ名
      server_group_name: <string>

      # GSLB向け: 実サーバ登録時の重み値
      weight: <number>

      # LB向け: 対象VIPのリスト
      # 省略した場合、このNICと同じネットワーク内に存在するVIP全てが対象となる
      vips: [ - <string> ]
      
      # LB向け: 実サーバ登録時のヘルスチェック
      health_check:
        # ヘルスチェックで用いるプロトコル
        protocol: < "http" | "https" | "ping" | "tcp" >
        
        # プロトコルがhttp/httpsの場合のリクエスト先パス 例:/index.html
        path: <string>
        # プロトコルがhttp/httpsの場合の期待するレスポンスステータスコード
        status_code: <number>

      # DNS向け: レコード登録時のレコード名 例:www
      record_name: <string>
      # DNS向け: レコード登録時のTTL
      record_ttl: <number>

# 子リソースの定義(省略可能)
resources:
  [ - <resource_definition> ]
```

`plans`を省略した場合、`size`に`min_size`から`max_size`までの値を持つプランが存在するとみなします。

#### <resource_selector>

```yaml
id: <string>
names: [ - <string> ]
```

### &lt;handler&gt;

カスタムハンドラーの定義。

```yaml
name: <string> #ハンドラ名
endpoint: <string> #gRPCのエンドポイントアドレス(例: unix:/var/run/your-custom-handler.sock)
```

### &lt;autoscaler_config&gt;

オートスケーラーの動作設定

```yaml
cooldown: <number | default = 600> # 同一ジョブの連続実行を抑制するためのクールダウン期間、秒単位で指定

# CoreのgRPCエンドポイントのTLS関連設定
server_tls_config:
  cert_file: <string> # 証明書のファイルパス
  key_file: <string> # 秘密鍵のファイルパス
  # クライアント認証タイプ: 詳細は https://golang.org/pkg/crypto/tls/#ClientAuthType を参照
  client_auth_type: <"NoClientCert" | "RequestClientCert" | "RequireAnyClientCert" | "VerifyClientCertIfGiven" | "RequireAndVerifyClientCert" >
  client_ca_file: <string> # クライアント認証で利用するCA証明書(チェイン)のファイルパス

# HandlersへのgRPCリクエスト時のTLS関連設定
handler_tls_config:
  cert_file: <string> # 証明書のファイルパス
  key_file: <string> # 秘密鍵のファイルパス 
  root_ca_file: <string> # ルート証明書(チェイン)のファイルパス

# Exporterの設定
exporter_config:
  enabled: <bool>
  address: <string | default=":8081">
  tls_config:
    cert_file: <string> # 証明書のファイルパス
    key_file: <string> # 秘密鍵のファイルパス
    # クライアント認証タイプ: 詳細は https://golang.org/pkg/crypto/tls/#ClientAuthType を参照
    client_auth_type: <"NoClientCert" | "RequestClientCert" | "RequireAnyClientCert" | "VerifyClientCertIfGiven" | "RequireAndVerifyClientCert" >
    client_ca_file: <string> # クライアント認証で利用するCA証明書(チェイン)のファイルパス
```

## 名前付きプラン

ELB/ルータ/サーバでは名前付きプランを利用可能です。  

```yaml
# サーバのでの名前付きプランの例
plans:
  - core: 2
    memory: 4
    name: "low"
  - core: 4
    memory: 8
  - core: 4
    memory: 16
    name: "medium"
  - core: 8
    memory: 16
  - core: 10
    memory: 24
    name: "high"
  - core: 10
    memory: 32
  - core: 10
    memory: 48
```

プラン名はInputsからの`DesiredStateName`パラメータで指定されます。  
Coreは`DesiredStateName`が指定されていると以下のようにあるべき姿を算出します。  

- Upリクエストがきた場合、現在のリソースのプランより大きな名前付きプランを返す
  見つからなかった場合はプラン変更せずエラーとする
  
- Downリクエストがきた場合、現在のリソースのプランより小さな名前付きプランを返す
  見つからなかった場合はプラン変更せずエラーとする
