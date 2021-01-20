# リファレンス / プロファイル

Usacloudのプロファイル機能はAPIキーなどの設定をファイルに保存/利用するためのものです。  

!!! info
    一部の項目は環境変数での設定に対応しています。  
    詳細は[リファレンス/環境変数](../env)を参照してください。

## プロファイルの作成

`usacloud config`コマンドでプロファイルの新規作成が可能です。

```bash
# 現在のプロファイルを編集(プロファイルが存在しない場合はdefaultプロファイルを作成)
$ usacloud config

# または名前を指定してプロファイルを作成(exampleプロファイルを作成)
$ usacloud config create example
```

## プロファイルに指定可能な値

プロファイルはJSONファイルとして記述します。
設定可能な項目は以下のとおりです。

### APIキー関連

- `AccessToken`(string): アクセストークン
- `AccessTokenSecret`(string): アクセスシークレット
- `Zones`([]string): 利用可能なゾーン、省略した場合は以下の値が利用される

[libsacloud: types.ZoneNames](https://github.com/sacloud/libsacloud/blob/master/v2/sacloud/types/zone.go#L30-L31)

### Usacloudコマンド動作関連

- `ArgumentMatchMode`(string): 操作対象リソースを引数で指定するコマンドでのリソース名と引数の比較方法(有効な値: `partial`(部分一致)/`exact`(完全一致))
- `DefaultOutputType`(string): デフォルトのアウトプットタイプ(有効な値: `table`/`json`/`yaml`)
- `DefaultQueryDriver`(string): 各コマンドの`--query`を処理するデフォルトのドライバ(有効な値: `jmespath`/`jq`)
- `NoColor`(bool): ANSIエスケープシーケンスによる色つけを無効化
- `ProcessTimeoutSec`(int): コマンド全体の実行タイムアウトまでの秒数

### API動作関連

- `AcceptLanguage`(string): リクエスト時のAccept-Languageヘッダ
- `RetryMax`(int): さくらのクラウAPIが423/503を返した際のリトライ回数
- `RetryWaitMin`(int): さくらのクラウドAPIが423/503を返した際のリトライ間隔(最小) (単位:秒)
- `RetryWaitMax`(int): さくらのクラウドAPIが423/503を返した際のリトライ間隔(最大) (単位:秒)
- `StatePollingTimeout`(int): 起動待ちなどのポーリング処理でのタイムアウト (単位:秒)
- `StatePollingInterval`(int): 起動待ちなどのポーリング処理でのポーリング間隔 (単位:秒)
- `HTTPRequestTimeout`(int): さくらのクラウドAPIリクエスト時のHTTPタイムアウト (単位:秒)
- `HTTPRequestRateLimit`(int): さくらのクラウドAPIリクエスト時の1秒あたりのリクエスト上限数
- `APIRootURL`(string): さくらのクラウドAPIのルートURL
- `DefaultZone`(string): グローバルリソースAPIを呼ぶ際に指定するゾーン

### デバッグ関連  

- `TraceMode`(string): 空でない場合は標準エラーにHTTPトレースログを出力
- `FakeMode`(bool): フェイクモードの有効化
- `FakeStorePath`(string): フェイクモードでのファイルストアパス

## プロファイルの設定例

```js
{
  "APIRootURL": "https://secure.sakura.ad.jp/cloud/zone",
  "AcceptLanguage": "en-US,en;q=0.9",
  "AccessToken": "<your-access-token>",
  "AccessTokenSecret": "<your-access-secret>",
  "ArgumentMatchMode": "exact",
  "DefaultOutputType": "table",
  "DefaultQueryDriver": "jq",
  "DefaultZone": "is1a",
  "FakeMode": false,
  "FakeStorePath": "~/.usacloud/fake_store.json",
  "HTTPRequestRateLimit": 5,
  "HTTPRequestTimeout": 300,
  "NoColor": false,
  "ProcessTimeoutSec": 7200,
  "RetryMax": 0,
  "RetryWaitMax": 64,
  "RetryWaitMin": 1,
  "StatePollingInterval": 0,
  "StatePollingTimeout": 0,
  "TraceMode": "HTTP",
  "Zone": "is1a",
  "Zones": ["is1a", "is1b", "tk1a", "tk1b", "tk1v"]
}
```