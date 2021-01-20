# restコマンド(上級者向け)

---

UsacloudではさくらのクラウドAPIを直接呼び出すための`usacloud rest`コマンドをサポートしています。

```bash
$ usacloud rest -h
Usage:
  usacloud rest [flags]
  usacloud rest [command]

Available Commands:
 === Basic Commands ===
    request     

Flags:
  -d, --data string           
  -h, --help                  help for rest
  -X, --method string         (*required) options: [get/post/put/delete/GET/POST/PUT/DELETE] (default "get")
      --query string          Query for JSON output
      --query-driver string   Name of the driver that handles queries to JSON output options: [jmespath/jq]
      --zone string
```

## restコマンドの挙動

`usacloud rest`コマンドはUsacloudのプロファイルやコマンドラインオプションなどからAPIキーなどの設定を参照してAPIリクエストを行うためのコマンドです。  
Usacloudコマンドによる抽象化を挟まずに直接APIリクエストを行い、レスポンスをそのまま出力します。

[さくらのクラウド APIドキュメント](https://developer.sakura.ad.jp/cloud/api/1.1/)を参照しながらAPIリクエストを行うようなユースケースを想定しています。  

## restコマンドの書式

以下の書式で実行します。

```bash
$ usacloud rest [オプション] <URL>
```

利用できるオプションは以下のとおりです。

- `-d`/`--data`: リクエストパラメータ。JSON文字列またはJSONを記述したファイルへのパスを指定  
(`curl`コマンドの`-d`オプションのような`@ファイルパス`形式には対応していません)
- `-X`/`--method`: リクエストのHTTPメソッド。`GET`/`POST`/`PUT`/`DELETE`が指定可能(小文字でもOK)  
- `--zone`: リクエスト先ゾーン、引数に`https://`で始まるURLを指定した場合は無効
- `--query`: 出力に対しJMESPath or jqで加工する際のクエリ文字列。文字列またはクエリを記述したファイルへのパスを指定
- `--query-driver`: `--query`の処理に使用するドライバー。`jmespath`/`jq`が指定可能

!!! Note
    `--query-driver`未指定時はプロファイルの`DefaultQueryDriver`の値が利用されます。  
    (`DefaultQueryDriver`のデフォルト値:`jmespath`)

引数には以下のパターンでURLを指定します。

- パターン1: URL全体を指定 - `https://secure.sakura.ad.jp/cloud/zone/is1a/api/cloud/1.1/server`
- パターン2: 部分的に指定 - `/server`

パターン2の場合、プロファイルからAPIルートURL(デフォルトは`https://secure.sakura.ad.jp/cloud/zone`)やゾーンなどを読み出してURLを補完します。  

## 利用例

```bash
# 特定サーバの電源をOFFにする
$ export SERVER_ID=123456789012
$ usacloud rest -X DELETE /server/$SERVER_ID/power 
```