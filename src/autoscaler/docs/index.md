# sacloud/autoscaler

## 概要

![logo.png](images/logo.svg)

`sacloud/autoscaler`(オートスケーラー)は、さくらのクラウド上のリソースのオートスケールを実現するためのツール群です。


!!! warning

    sacloud/autoscalerは現在開発中です。
    v1.0に達するまではコンフィギュレーションなどについて互換性のない形で変更される可能性があることにご注意ください。

## コンセプト/アーキテクチャ

![architecture](images/architecture.png)

sacloud/autoscalerはGrafanaやPrometheusといった監視ツールと連携し、さくらのクラウド上のリソースの水平スケールや垂直スケールを行います。   
  
以下の3つの論理的なコンポーネントから構成されています。

- `Inputs`: なんらかのトリガーを受け、Coreに対してスケール指示を出す
- `Core`: Inputsからの指示を受け、あらかじめ定義されたコンフィギュレーションに従いさくらのクラウド上のリソースのあるべき姿を算出、Handlersに指示を出す
- `Handlers`: Coreからの指示を受け、さくらのクラウド上のリソースの更新などのリソース操作を担当する

GrafanaやPrometheusに対応するInputs、サーバやエンハンスドロードバランサのスケール動作に対応するHandlersがビルトインとして提供されています。
各コンポーネント間の連携にはgRPCを用いており、InputsやHandlersとして独自のコンポーネントを実装して利用することも出来ます。

## インストール

GitHub Releasesから実行ファイルをダウンロードしインストールします。  
詳細は[Getting Starget](./getting_started/)を参照してください。  

## 基本的な使い方

操作対象のリソースを定義したコンフィギュレーションファイルを用意し、`autoscaler`コマンドを通じてCoreやビルトインInputsを起動します。

```bash
# コンフィギュレーションファイルの雛形を出力
$ autoscaler example > autoscaler.yaml

# コンフィギュレーションファイルのバリデーション
# autoscaler validate

# Coreの起動
$ autoscaler start

# Inputsの起動(Grafana向け)
$ autoscaler inputs grafana 
```

!!! tips

    ビルトインHandlersはCoreに含まれており別途起動する必要はありません。

## コンフィギュレーション

コンフィギュレーションファイルではさくらのクラウド上のスケールさせたいリソースを定義します。  

```yaml
# コンフィギュレーションファイルの構造
resources:
 # 操作対象のリソース1 
 - name: "resource1" 
   type: "Server"  
   # リソースごとに固有の設定項目...
     
 # 操作対象のリソース2 
 - name: "resource2"
   type: "ServerGroup"
   # リソースごとに固有の設定項目...
```

定義可能なリソースは以下の通りです。  
詳細は各リソースのコンフィギュレーションリファレンスを参照してください。

#### 水平スケール

  - [サーバグループ(`ServerGroup`)](./configuration/#resource_def_server_group): 台数

#### 垂直スケール

  - [サーバ(`Server`)](./configuration/#resource_def_server): CPU/メモリ
  - [エンハンスドロードバランサ(`ELB`)](./configuration/#resource_def_elb): CPS
  - [ルータ(`Router`)](./configuration/#resource_def_router): 帯域

