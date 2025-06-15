# ウェブアクセラレータサイト情報: sakuracloud_webaccel

ウェブアクセラレータのサイト情報を参照するためのデータソース

## Example Usage

```tf
# サイト情報を取得
data sakuracloud_webaccel "site" {
  name = "your-site-name"
  # or
  # domain = "your-domain"
}
```

<div class="editor">

<h2><a href="https://zouen-alpha.usacloud.jp/#data/webaccel" target="_blank" rel="noopener noreferrer">Code Editor</a></h2>

<iframe src="https://zouen-alpha.usacloud.jp/#data/webaccel"></iframe>

</div>


## Argument Reference

* `name` - (Optional) 対象サイトの名前
* `domain` - (Optional) 対象サイトのドメイン名

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

`origin_parameters`ブロックは以下の属性値をサポートする。

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
