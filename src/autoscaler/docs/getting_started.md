# Getting Started Guide

## 利用までの流れ

- インストール
- Coreの設定ファイルの作成
- Coreの起動
- Inputsの起動
- Grafana/AlertManagerの設定

## インストール

GitHub Releasesから実行ファイルをダウンロードします。  

[sacloud/autoscaler リリースページ](https://github.com/sacloud/autoscaler/releases/latest)

ダウンロードしたら適切なディレクトリに保存/展開してください。

CLIの利用方法については[CLIリファレンス](./cli.md)を参照してください。

#### Dockerを利用する場合

GitHub Container RegistryでDockerイメージを配布しています。  
Dockerを利用する場合は以下のようにします。  

```bash
# Coreを起動する場合(Unixドメインソケットでリッスン)
$ docker run -d -w /work -d /your/work/dir:/work ghcr.io/sacloud/autoscaler start

# Grafana Inputsを起動する場合(CoreとはVolume経由でUnixドメインソケットを受け渡して通信する)
$ docker run -d -w /work -d /your/work/dir:/work ghcr.io/sacloud/autoscaler inputs grafana --addr ":8080"

# AlertManager Inputsを起動する場合(CoreとはVolume経由でUnixドメインソケットを受け渡して通信する)
$ docker run -d -w /work -d /your/work/dir:/work ghcr.io/sacloud/autoscaler inputs alertmanager --addr ":8080"
```

#### Docker Composeを利用する場合(開発環境向け)

開発環境での動作確認向けにDocker ComposeでPrometheus/Grafana/AutoScalerの動作確認を行うための例を提供しています。
[examples/docker-compose](https://github.com/sacloud/autoscaler/blob/master/examples/docker-compose)を参照してください。  

#### systemdを利用する場合

[examples/systemd](https://github.com/sacloud/autoscaler/blob/master/examples/systemd/)を参照してください。

## Coreの設定ファイル(autoscaler.yaml)の作成

sacloud/autoscalerを実行するにはYAML形式の設定ファイルで対象リソースの定義などを行う必要があります。  

設定ファイルの雛形は`autoscaler example`で出力できます。
設定ファイルの記載内容については[Configuration Reference](./configuration.md)を参照してください。

## Coreの起動

以下のコマンドでCoreを起動します。  

```bash
# デフォルト設定で起動
$ autoscaler start 
```

指定可能なオプションは以下の通りです。

```console
$ autoscaler start -h

start autoscaler's core server

Usage:
  autoscaler start [flags]...

Flags:
      --addr string     Address of the gRPC endpoint to listen to (default "unix:autoscaler.sock")
      --config string   File path of configuration of AutoScaler Core (default "autoscaler.yaml")
  -h, --help            help for start
      --strict          Restricting external file loading, etc. in configuration

Global Flags:
      --log-format string   Format of logging to be output. options: [ logfmt | json ] (default "logfmt")
      --log-level string    Level of logging to be output. options: [ error | warn | info | debug ] (default "info")
```

Note: Coreはデフォルトだと`unix:autoscaler.sock`でリッスンします。  
Inputsを別のマシン上で動かす場合などは`--addr`フラグで`192.0.2.1:8080`や`your-host-name.com:8080`のようなアドレスを指定する必要があります。  

## Inputsの起動

以下のコマンドでInputsを起動します。

```shell
# Grafana Inputsの場合
$ autoscaler inputs grafana

# AlertManager Inputsの場合
$ autoscaler inputs alertmanager

# Zabbix Inputsの場合
$ autoscaler inputs zabbix

# 汎用Webhook Inputsの場合
$ autoscaler inputs webhook --accept-http-methods "POST,PUT" --executable-path your-executable-path.sh

# Direct Inputsの場合
$ autoscaler inputs direct up
```

## 外部監視ツール側の設定

Grafana、AlertManager、またはZabbixを利用する場合、各プロダクト側でアラートの設定、およびWebhookでの通知設定が必要です。  
詳細は[Inputsドキュメント](../inputs/)を参照してください。  