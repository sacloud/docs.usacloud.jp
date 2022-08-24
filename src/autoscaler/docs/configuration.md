# Configuration Reference

sacloud/autoscalerのコンフィギュレーションファイルはYAML形式で書かれた、操作対象のリソース定義や動作を調整するためのものです。  

## コンフィギュレーションファイルの例:

```yaml
# 操作対象のリソースの定義
# スケールさせたいリソース群をここで定義する
resources:
  # サーバ(垂直スケール)
  - type: Server
    name: "server"
    selector:
      names: ["example"]
      zones: ["is1a"]
    shutdown_force: true

    # 親リソース(GSLB)
    # GSLB配下のサーバが垂直スケールする際にサーバのデタッチ&アタッチが行われる
    parent:
      type: GSLB
      selector: "example-gslb"

# カスタムハンドラーの定義
# handlers:
#   - name: "fake"
#     endpoint: "unix:autoscaler-handlers-fake.sock"

# オートスケーラーの動作設定
autoscaler:
  cooldown: 600 

# さくらのクラウド API関連
# sakuracloud:
#   # Usacloud互換のプロファイル機能でAPIキーを指定
#   profile: "<your-profile-name>"
#
#   # APIキーの直接指定も可能
#   token: "<your-token>"
#   secret: "<your-secret>"
```

## スキーマ

- [&lt;top_level&gt;](#top_level)
  - [&lt;resource_definition&gt;](#resource_definition) 
    - [&lt;resource_def_elb&gt;](#resource_def_elb)
    - [&lt;resource_def_router&gt;](#resource_def_router)
    - [&lt;resource_def_server&gt;](#resource_def_server)
    - [&lt;resource_def_server_group&gt;](#resource_def_server_group)
  - [&lt;parent_definition&gt;](#parent_definition)
  - [&lt;resource_selector&gt;](#resource_selector)
  - [&lt;name_or_resource_selector&gt;](#name_or_resource_selector)
  - [&lt;handler&gt;](#handler)
  - [&lt;autoscaler_config&gt;](#autoscaler_config)

### 基本データ型

- <string>: 文字列
- <bool>: 真偽値
- <number>: 数値
- <filepath>: ファイルパス。相対パスを指定した場合、AutoScaler Coreのカレントディレクトリが基準

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
  # Usacloud互換のプロファイルの名称
  # 環境変数SAKURACLOUD_PROFILEでの指定も可能
  # 省略した場合は~/.usacloud/currentの値を参照します
  profile: <string>
  
  # APIトークン、省略した場合は環境変数SAKURACLOUD_ACCESS_TOKENを参照します
  token: <string>
  # APIシークレット、省略した場合は環境変数SAKURACLOUD_ACCESS_TOKEN_SECRETを参照します
  secret:  <string>
```

### &lt;resource_definition&gt;

操作対象となるさくらのクラウド上のリソースの定義
resource_def_xxxのいずれかを指定します。

```yaml
<resource_def_elb> | <resource_def_router> | <resource_def_server> | <resource_def_server_group>
```

### &lt;resource_def_elb&gt;

エンハンスドロードバランサの定義。  
ここで定義したリソースは垂直スケール可能になります(ハンドラ`elb-vertical-scaler`)。  

```yaml
type: "ELB" # or EnhancedLoadBalancer
name: <string>
selector:
  # idかnames or tagsのどちらかを指定、必須
  id: <string> | <number>
  # 部分一致、複数指定した場合はAND結合
  names:
          [ - <string> ]
  tags:
          [ - <string> ]
# 垂直スケールさせる範囲(省略可能)
plans:
  [ - name: <string> # プラン名、省略可能 
      cps: <number> ]

# スケール後のセットアップ猶予時間(省略時は0秒)
setup_grace_period: <number>
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

### &lt;resource_def_router&gt;

ルータの定義。  
ここで定義したリソースは垂直スケール可能になります(ハンドラ`router-vertical-scaler`)。  

```yaml
type: "Router"
name: <string>
selector:
  # idかnames or tagsのどちらかを指定、必須
  id: <string> | <number>
  # 部分一致、複数指定した場合はAND結合
  names:
          [ - <string> ]
  tags:
          [ - <string> ]
  # ゾーン(必須) 
  zones:
          [ - <"is1a" | "is1b" | "tk1a" | "tk1b" | "tk1v"> ]
# 垂直スケールさせる範囲(省略可能)
plans:
  [ - name: <string> # プラン名、省略可能 
      band_width: <number> ]

# スケール後のセットアップ猶予時間(省略時は0秒)
setup_grace_period: <number>
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
`parent`を定義した場合、サーバの垂直スケール前後に`parent`が示すリソースからのデタッチ/アタッチが行われます。

```yaml
type: "Server"
name: <string>
selector:
  # idかnames or tagsのどちらかを指定、必須
  id: <string> | <number>
  # 部分一致、複数指定した場合はAND結合
  names:
          [ - <string> ]
  tags:
          [ - <string> ]
  # ゾーン(必須) 
  zones:
          [ - <"is1a" | "is1b" | "tk1a" | "tk1b" | "tk1v"> ]
  
# コア専有プランを利用するか
dedicated_cpu: <bool>
  
# 強制シャットダウンを行うか(ACPIが利用できないサーバの場合trueにする)
shutdown_force: <bool> 
  
# 垂直スケールさせる範囲(省略可能)
plans:
  [ - name: <string> # プラン名、省略可能 
      core: <number> # コア数
      memory: <number> #メモリサイズ、GB単位 
  ]

# スケール後のセットアップ猶予時間(省略時は60秒)
setup_grace_period: <number>
  
# 親リソースの定義(省略可能)
parent: <parent_definition>
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
`parent`を定義した場合、サーバの垂直スケール前後に`parent`が示すリソースからのデタッチ/アタッチが行われます。

```yaml
type: "ServerGroup"
name: <string> 

# 対象サーバの指定
server_name_prefix: <string> #グループ内の各サーバ名のプレフィックス、省略した場合はnameが利用される
zone: <"is1a" | "is1b" | "tk1a" | "tk1b" | "tk1v">
  
# 最小/最大サーバ数
min_size: <number>
max_size: <number>

# 名前付きプラン(サーバグループの場合はサーバ数をプランとして表す)
plans:
  [ - name: <string> # プラン名、省略可能 
      size: <number> # サーバ数
  ]

# スケール後のセットアップ猶予時間(省略時は0秒)
setup_grace_period: <number>

# 強制シャットダウンを行うか(ACPIが利用できないサーバの場合trueにする)
shutdown_force: <bool>

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
    dedicated_cpu: <bool> # コア専有の場合true
    
  # 接続するディスクをリストで指定  
  disks:
    [ - name_prefix: <string> # ディスク名のプレフィックス(省略可能)
        tags: [ - <string> ]
        description: <string>
        
        icon_id: <string>
        
        source_archive: <name_or_resource_selector>
        source_disk: <name_or_resource_selector>
        os_type: <string>
        
        plan: <"ssd" | "hdd">
        connection: <"virtio" | "ide">
        size: <number>
    ]
  
  # ディスクの修正パラメータ、cloud_configとの併用は出来ない
  edit_parameter:
    disabled: <bool>        # ディスクの修正を行わない場合true
    host_name_prefix: <string> # ホスト名のプレフィックス(省略可能)
    password: <string>
    disable_pw_auth: <bool>
    enable_dhcp: <bool>
    change_partition_uuid: <bool>
    startup_scripts: [ - <string> | <filepath> ]
    ssh_keys: [ - <string> | <filepath> ]
    ssh_key_ids: [ - <string> ]
    
  # cloud-init用のパラメータ、edit_parameterとの併用は出来ない  
  cloud_config: <string> | <filepath>
    
  network_interfaces:
    # 上流ネットワーク
    upstream: <"shared"> | <resource_selector>
    
    packet_filter_id: <string>
    # 以下はupstreamがshared以外の場合のみ指定可能
    assign_cidr_block: <string>
    assign_netmask_len: <int>
    default_route: <string>
    
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

# 親リソースの定義(省略可能)
parent: <parent_definition>
```

`plans`を省略した場合、`size`に`min_size`から`max_size`までの値を持つプランが存在するとみなします。

#### &lt;parent_definition&gt;

```yaml
type: < "DNS" | "EnhancedLoadBalancer" | "ELB" | "GSLB" | "LoadBalancer" >
selector: <name_or_resource_selector>
```

#### &lt;resource_selector&gt;

```yaml
id: <string>
names: [ - <string> ]
tags: [ - <string> ]
```

#### &lt;name_or_resource_selector&gt;

```yaml
<string> | <resource_selector>
```

文字列が指定された場合はnamesのみが指定されたresource_selectorと同等とみなします。  

```yaml
# 文字列を指定した場合
selector: "name"

# 以下と同等
# selector:
#   names: ["name"]
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

# ビルトインハンドラの設定
handlers_config:
  disabled: <bool> # すべてのビルトインハンドラの無効化(handlersでの指定より優先される)
  handlers:        # ビルトインハンドラごとの設定、ハンドラ名をキーにもつmap
    <string>:          # ビルトインハンドラ名
      disabled: <bool> # このハンドラを無効化するか

# Exporterの設定
exporter_config:
  enabled: <bool>
  address: <string | default=":8081">
```