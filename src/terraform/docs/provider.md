# SakuraCloudプロバイダー

さくらのクラウド上の各種リソースを操作するためのプロバイダー

## Example

```tf
# Configure the SakuraCloud Provider
terraform {
  required_providers {
    sakuracloud = {
      source = "sacloud/sakuracloud"

      # We recommend pinning to the specific version of the SakuraCloud Provider you're using
      # since new versions are released frequently
      version = "2.25.0"
      #version = "~> 2"
    }
  }
}
provider "sakuracloud" {
  # More information on the authentication methods supported by
  # the SakuraCloud Provider can be found here:
  # https://docs.usacloud.jp/terraform/provider/

  # profile = "..."
}
```

## APIの認証方法の設定

さくらのクラウドプロバイダーでは以下のAPI認証方法をサポートしています。

- tfファイル(Static credential)
- 環境変数(Environment variables)
- プロファイル(Shared credentials file)

複数利用した場合より上に書いてある方法が優先されます。

### tfファイル(Static credential)

!!! warning
    tfファイル上にAPIキー(トークン/シークレット)を記載する方法は非推奨です。  
    この方法には、GitHubなどのパブリックなリポジトリ上でAPIキーを公開してしまうリスクがあります。  
    テスト/検証以外では利用しないでください。

tfファイル上の`sakuracloud`プロバイダーブロック内にインラインで`token`と`secret`を指定します。

使用例:

```tf
provider "sakuracloud" {
  token  = "my-access-token"
  secret = "my-access-secret"
  zone   = "is1a"
}
```

### 環境変数(Environment variables)

環境変数`SAKURACLOUD_ACCESS_TOKEN`と`SAKURACLOUD_ACCESS_TOKEN_SECRET`を指定することでAPIキーを指定可能です。

```tf
provider "sakuracloud" {}
```

Usage:

```sh
$ export SAKURACLOUD_ACCESS_TOKEN="my-access-token"
$ export SAKURACLOUD_ACCESS_TOKEN_SECRET="my-access-secret"
$ export SAKURACLOUD_ZONE="is1a"
$ terraform plan
```

### プロファイル(Shared credentials file)

`sakuracloud`プロバイダーブロック内で`profile`を指定することによりUsacloud形式のプロファイルを利用可能です。  
プロファイルはAPIキーなどの情報を格納したJSONファイルで、デフォルトでは以下の場所に保存されています。  

- Linux/macOS: `$HOME/.usacloud/<profile name>/config.json`
- Windows: `%USERPROFILE%\.usacloud\<profile name>/config.json`

このファイルは`usacloud profile edit <profile name>`コマンドや直接テキストエディタ開くことで編集可能です。  

プロファイルJSONの例:

```bash
$ cat $HOME/.usacloud/default/config.json
{
	"AccessToken": "my-access-token",
	"AccessTokenSecret": "my-access-secret",
	"Zone": "is1a"
}
```

## Argument Reference

* `accept_language` - (Optional) APIリクエスト時に付与する`AcceptLanguage`ヘッダの値   
環境変数`SAKURACLOUD_ACCEPT_LANGUAGE`、またはプロファイルでの指定が可能
* `api_request_rate_limit` - (Optional) API呼び出しの秒あたりの上限数  
 環境変数`SAKURACLOUD_RATE_LIMIT`、またはプロファイルでの指定が可能。デフォルト:`10`
* `api_request_timeout` - (Optional) APIリクエストのHTTPタイムアウト秒数  
環境変数`SAKURACLOUD_API_REQUEST_TIMEOUT`、またはプロファイルでの指定が可能。デフォルト:`300`
* `api_root_url` - (Optional) APIリクエスト先のルートURL  
環境変数`SAKURACLOUD_API_ROOT_URL`、またはプロファイルでの指定が可能。デフォルト:`https://secure.sakura.ad.jp/cloud/zone`
* `fake_mode` - (Optional) (開発者向け) APIリクエストをFakeドライバーで処理するためのフラグ  
環境変数`FAKE_MODE`、またはプロファイルでの指定が可能 
* `fake_store_path` - (Optional) (開発者向け) Fakeドライバーの使用するデータストアのパス。省略した場合インメモリーストアが利用される  
環境変数`FAKE_STORE_PATH`、またはプロファイルでの指定が可能 
* `profile` - (Optional) プロファイル名。デフォルト:`default`
* `retry_max` - (Optional) APIのレスポンスコードが`423`/`503`の場合にリトライする最大回数   
環境変数`SAKURACLOUD_RETRY_MAX`、またはプロファイルでの指定が可能。デフォルト:`100`
* `retry_wait_max` - (Optional) APIのレスポンスコードが`423`/`503`の場合にリトライする際の待ち時間秒数最大値   
環境変数`SAKURACLOUD_RETRY_WAIT_MAX`、またはプロファイルでの指定が可能。デフォルト:`64`
* `retry_wait_min` - (Optional) APIのレスポンスコードが`423`/`503`の場合にリトライする際の待ち時間秒数最小値   
環境変数`SAKURACLOUD_RETRY_WAIT_MIN`、またはプロファイルでの指定が可能。デフォルト:`1`
* `secret` - (Optional) APIキー(シークレット)   
環境変数`SAKURACLOUD_ACCESS_TOKEN_SECRET`、またはプロファイルでの指定が可能 
* `token` - (Optional) APIキー(トークン)   
環境変数`SAKURACLOUD_ACCESS_TOKEN`、またはプロファイルでの指定が可能
* `trace` - (Optional) トレースログの出力を有効にするフラグ   
環境変数`SAKURACLOUD_TRACE`、またはプロファイルでの指定が可能
* `zone` - (Optional) デフォルトゾーン名   
環境変数`SAKURACLOUD_ZONE`、またはプロファイルでの指定が可能 
* `zones` - (Optional) 利用可能なゾーン名のリスト。利用可能なゾーンを制限したい場合などに利用する   
プロファイルでの指定が可能  デフォルト:[`is1a`, `is1b`, `tk1a`, `tk1b`, `tk1v`]

