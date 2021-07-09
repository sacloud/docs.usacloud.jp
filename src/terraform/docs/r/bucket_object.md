# バケットオブジェクト: sakuracloud_bucket_object

!!! Note
    バケットの作成はAPI経由では行えません。  
    このため、このリソースを利用する場合はあらかじめバケットを手動で作成しておく必要があります。

## Example Usage

```hcl
resource "sakuracloud_bucket_object" "foobar" {
  bucket  = "foobar"
  key     = "example.txt"
  content = file("example.txt")
}
```

## Argument Reference

* `access_key` - (Required) オブジェクトストレージAPIのアクセスキー
* `secret_key` - (Required) オブジェクトストレージAPIのシークレットキー
* `bucket` - (Required) バケット名 / この値を変更するとリソースの再作成が行われる
* `key` - (Required) オブジェクトのキー(ファイル名) / この値を変更するとリソースの再作成が行われる
* `content` - (Optional) オブジェクトのコンテンツ /[`source`]と同時に指定できません
* `content_type` - (Optional) Content-Type
* `etag` - (Optional) HTTP ETag
* `source` - (Optional) オブジェクトのコンテンツファイルのパス / `content`と同時に指定できません

## Attribute Reference

* `id` - ID
* `http_cache_url` - キャッシュアクセスURL(http)
* `http_path_url` - パス形式のアクセスURL(http)
* `http_url` - アクセスURL(http)
* `https_cache_url` - キャッシュアクセスURL(https)
* `https_path_url` - パス形式のアクセスURL(https)
* `https_url` - アクセスURL(https)
* `last_modified` - 最終更新日時
* `size` - サイズ(byte単位)

