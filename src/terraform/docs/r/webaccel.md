---
layout: "sakuracloud"
page_title: "ウェブアクセラレーター (サイト): sakuracloud_webaccel"
subcategory: "WebAccelerator"
description: |-
  ウェブアクセラレーターのサイトを管理する
---

# sakuracloud_webaccel

ウェブアクセラレーターのサイトを管理するためのリソース

!!! note
    このリソースを作成してもサイトは有効化されません。
    作成したサイトを有効化するには`webaccel_activation`リソースを利用して下さい。

## 利用例

```hcl
resource "sakuracloud_webaccel" "foobar" {
  name             = "hoge"
  domain_type      = "subdomain"
  request_protocol = "https-redirect"
  origin_parameters {
    type     = "web"
    origin   = "docs.usacloud.jp"
    protocol = "https"
  }
  logging {
    s3_bucket_name = "example-bucket"
    s3_access_key_id = "xxxxxxxxxxxxxxx"
    s3_secret_access_key = "xxxxxxxxxxxxxxxxxxxxxxx"
    enabled = true
  }
  onetime_url_secrets = [
    "abc-0x123456"
  ]
  vary_support      = true
  default_cache_ttl = 3600
  normalize_ae      = "gzip"
}
```

## Argument Reference

* `name` - (Required) サイト名
* `domain_type` - (Required) サイトのドメイン種別 / 次のいずれかを指定 [`own_domain`/`subdomain`]
* `request_protocol` - (Required) サイトに対するリクエストプロトコル / 次のいずれかを指定 [`http+https`/`https`/`https-redirect`]
* `onetime_url_secrets` - (Optional) ワンタイムURLシークレットの一覧 / 3つ以上のシークレットは指定不可
* `vary_support` - (Optional) サイトがVaryヘッダーをサポートするかどうか
* `default_cache_ttl` - (Optional) コンテンツキャッシュのデフォルトTTL秒数
* `normalize_ae` - Accept-Encoding正規化の対象となる圧縮アルゴリズム / 次のいずれかを指定 [`gzip`/`br+gzip`]

---

`origin_parameters` ブロックは以下の引数を指定可能。

#### Core Origin Arguments

* `type` - (Required) オリジン種別 / 次のいずれかを指定 [`web`/`bucket`]

#### Web Origin Arguments (`web`オリジンでのみ指定可)

* `origin` - (Required) オリジンのホスト名もしくはIPv4アドレス
* `protocol` - (Required) オリジン接続に用いるプロトコル / 次のいずれかを指定 [`http`/`https`]
* `host_header` - (Optional) オリジン接続に用いるHTTPホストヘッダー

#### Bucket Origin Arguments (`bucket`オリジンでのみ指定可)

* `s3_endpoint` - (Required) S3エンドポイントのホスト名 / さくらのオブジェクトストレージを利用する場合は`s3.isk01.sakurastorage.jp`
* `s3_region` - (Required) S3リージョン / さくらのオブジェクトストレージを利用する場合は `jp-north-1` 
* `s3_bucket_name` - オリジンバケット名 / バケットプレフィクスは指定できない
* `s3_access_key_id` - バケットへの接続で利用するS3アクセスキーID
* `s3_secret_access_key` - バケットへの接続で利用するS3シークレットアクセスキー
* `s3_doc_index` - (Optional) ドキュメントインデクスを有効化するかどうか / デフォルト: `false`

---

`logging` ブロックは以下の引数を設定可能。

* `s3_bucket_name` - ログ保管先のバケット名 / さくらのオブジェクトストレージのバケットを指定する必要がある
* `s3_access_key_id` - バケットへの接続で利用するS3アクセスキーID
* `s3_secret_access_key` - バケットへの接続で利用するS3シークレットアクセスキー
* `enabled` - アクセスログを有効化するか否か / デフォルト: `false`

## Attribute Reference

* `id` - ウェブアクセラレーターのサイトID
* `cname_record_value` - DNSに設定できるCNAMEレコードの値
* `subdomain` - サイトのFQDN
* `txt_record_value` - ドメインの所有権を確認するために利用できるTXTレコードの値
* `request_protocol` - (Required) サイトに対するリクエストプロトコル 
* `vary_support` - サイトがVaryヘッダーをサポートするかどうか
* `default_cache_ttl` - コンテンツキャッシュのデフォルトTTL秒数
* `normalize_ae` - Accept-Encoding正規化の対象となる圧縮アルゴリズム

---

`origin_parameters`ブロックでは以下の属性値をサポートする。

* `type` - オリジン種別
* `origin` - オリジンのホスト名もしくはIPv4アドレス
* `protocol` - オリジン接続に用いるプロトコル
* `host_header` - オリジン接続に用いるHTTPホストヘッダー
* `s3_endpoint` - S3エンドポイントのホスト名
* `s3_region` - S3リージョン
* `s3_bucket_name` - オリジンバケット名
* `s3_access_key_id` - バケットへの接続で利用するS3アクセスキーID
* `s3_secret_access_key` - バケットへの接続で利用するS3シークレットアクセスキー
* `s3_doc_index` - ドキュメントインデクスを有効化するかどうか


---

`logging`ブロックは以下の属性値をサポートする。

* `s3_bucket_name` - ログ保管先のバケット名
* `enabled` - アクセスログ取得が有効か否か
