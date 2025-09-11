# Direct Inputs

Direct Inputsを利用する方法ついて記載します。  

## Direct Inputsとは

コマンドラインからAutoScaler Coreへ直接Up/Downリクエストを送信するためのCLIです。  
cronでの実行や動作確認などで利用します。

## 前提条件

- Direct InputsからAutoScaler Coreへの疎通が可能なこと

## 利用方法

`autoscaler inputs direct`で実行可能です。  
指定可能なオプションなどは以下の通りです。  

```shell
$ autoscaler inputs direct -h

Send Up/Down/Keep request directly to Core server

Usage:
  autoscaler inputs direct {up | down | keep} [flags]...

Flags:
      --config string               Filepath to Inputs additional configuration file
      --desired-state-name string   Name of the desired state defined in Core's configuration file
      --dest string                 Address of the gRPC endpoint of AutoScaler Core. 
                                    If no value is specified, it will search for a valid value among the following values and use it.
                                    [unix:autoscaler.sock, unix:/var/run/autoscaler.sock, unix:/var/run/autoscaler/autoscaler.sock]
  -h, --help                        help for direct
      --resource-name string        Name of the target resource (default "default")
      --source string               A string representing the request source, passed to AutoScaler Core (default "default")
      --sync                        Flag for synchronous handling  
      
Global Flags:
      --log-format string   Format of logging to be output. options: [ logfmt | json ] (default "logfmt")
      --log-level string    Level of logging to be output. options: [ error | warn | info | debug ] (default "info")
```

## 非同期モード/同期モードについて

### 非同期モード(デフォルト)

`autoscaler inputs direct`はデフォルトだと非同期モードで動作します。  
非同期モードではCoreに対しUp or Downリクエストを投げた後、結果を待たずにコマンド実行を終了します。  

### 同期モード

`--sync`を指定することで同期モードとなります。  
同期モードではCoreに対しUp or Downリクエストを投げると、結果が返ってくるまで待機します。

### 同期モードでの終了コード

同期モードではコマンドの実行結果に応じて以下のいずれかの終了コードを返します。

- `0`: 正常終了(JOB_DONE)の場合
- `1`: 何らかのエラーが発生した場合
- `129`: up/downリクエストを受け取ったが処理なし(JOB_DONE_NOOP)の場合
- `130`: up/downリクエストが受け入れられない状態の場合(処理の実行中やcooldown期間中、シャットダウン中の場合など)
