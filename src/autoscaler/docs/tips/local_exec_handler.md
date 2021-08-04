# local-execハンドラの使用

## local-execハンドラ

オートスケール時に任意のシェルスクリプトなどの実行可能ファイルでプロビジョニングを行うためのカスタムハンドラです。  

通常、水平スケール時にはPackerなどを用いてソースアーカイブをあらかじめ作成しておく方法、
またはスタートアップスクリプトを利用するといった方法でサーバのプロビジョニングを行います。  
local-execハンドラはこれらの方法に加え、任意のスクリプトを用いてさまざまなリソースのプロビジョニングを行うための手段を提供します。  

## 利用方法

### local-execハンドラの起動

Coreを起動する前に、任意の実行可能ファイルを指定してlocal-execハンドラを起動しておく必要があります。  

#### 実行可能ファイルの例

```bash
#!/bin/bash

# 標準入力経由で渡されるパラメータをそのまま標準出力に書き込む
cat
```

#### local-execハンドラの起動例

```bash
$ autoscaler handlers local-exec --executable-path handler.sh --handler-type post-handle
```

### カスタムハンドラを定義

Coreのコンフィギュレーションファイルでカスタムハンドラを定義しておく必要があります。  

```yaml
handlers:
  - name: "local-exec" # 任意の名称
    endpoint: "unix:autoscaler-handlers-local-exec.sock"
```

定義後は通常通りCoreを起動することでカスタムハンドラが利用可能になっています。

!!! tips
    カスタムハンドラを定義した場合、Coreの起動時にカスタムハンドラとの疎通確認が行われます。  
    このため、Coreを起動するより前にカスタムハンドラを起動しておく必要があります。


## 仕様

### 実行可能ファイル

local-execハンドラの子プロセスとして実行されます。  
実行可能ファイルにはlocal-execハンドラの実行ユーザーが実行可能なように適切なパーミッションを設定しておく必要があります。

例:
```bash
$ chmod +x handler.sh
```

### local-execハンドラCLI

AutoScalerのCLIにビルトインされています。  

```bash
$ autoscaler handlers local-exec -h

Handler for executing a shell script

Usage:
  autoscaler handlers local-exec [flags]... {path/to/your/executable}

Flags:
      --addr string              the address for the server to listen on (default "unix:autoscaler-handlers-local-exec.sock")
      --config string            Filepath to Handlers additional configuration file
      --executable-path string   Path to the executable
      --handler-type string      Handler type name
  -h, --help                     help for local-exec

Global Flags:
      --log-format string   Format of logging to be output. options: [ logfmt | json ] (default "logfmt")
      --log-level string    Level of logging to be output. options: [ error | warn | info | debug ] (default "info")
```

#### `--handler-type`パラメータについて

どのタイミングで実行するのかを制御するためのものです。以下の値が指定可能です。

- `pre-handle`: リソース操作前に実行される。パラメータとしてHandleRequestが渡される。
- `handle`: リソース操作時に実行される。パラメータとしてHandleRequestが渡される。
- `post-handle`: リソースの操作後に実行される。パラメータとしてPostHandleRequestが渡される。

### 入出力

#### 入力

実行時には標準入力経由で処理対象のリソースについてのパラメータが渡されます。  

##### 標準入力経由で渡されるパラメータの例

```json
# PostHandleRequestの例
{
  "source": "example",
  "resource_name": "example",
  "scaling_job_id": "example",
  "result": 1, 
  "current": {
    "Resource": ...
  }
}
```

パラメータの書式はハンドラ向けのprotoファイルで定義されている`HandleRequest`、または`PostHandleRequest`をJSONに変換したものです。

- protoファイル: [https://github.com/sacloud/autoscaler/blob/main/protos/handler.proto](https://github.com/sacloud/autoscaler/blob/main/protos/handler.proto)
- HandleRequest/PostHandleRequestの定義(go): [https://github.com/sacloud/autoscaler/blob/main/handler/handler.pb.go](https://github.com/sacloud/autoscaler/blob/main/handler/handler.pb.go)

#### 出力

標準出力に書き込むとCoreとlocal-execハンドラのログに出力されます。  
標準エラーへの書き込みは無視されます。  

##### 標準入力経由でパラメータを読み取る例:

以下の例はPostHandleのタイミングでTerraformのステートファイルを更新するものです。  
入力されるJSONの`.result`フィールドが`1`(CREATED) or `2`(UPDATED) or `3`(DELETED)のいずれかであるかをjqコマンドを用いて判定します。  

```bash
#!/bin/bash

# CREATED/UPDATED/DELETEDの場合はterraformのステートをリフレッシュする
SHOULD_HANDLE=$(jq '[.] | any(.result == 1 or .result == 2 or .result == 3)')

if [ "$SHOULD_HANDLE" == "true" ]; then
  WORKING_DIR=$(cd $(dirname $0); pwd)
  terraform -chdir="$WORKING_DIR" apply -refresh-only -auto-approve 2>&1 1> /dev/null
  exit $?
else
  echo "ignored"
  exit 0
fi
```