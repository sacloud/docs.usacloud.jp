# シンプルMQ: sakuracloud_simple_mq

!!! warning
    キューのAPIキーの発行はterraformでは行えません。
    発行するには、[さくらのクラウドコントロールパネル](https://secure.sakura.ad.jp/cloud/)や[さくらのクラウドAPI](https://manual.sakura.ad.jp/api/cloud/simplemq/sacloud/#operation/rotateAPIKey)を利用してください。

## Example Usage

```hcl
resource "sakuracloud_simple_mq" "foobar" {
  name        = "foobar"
  description = "description"
  tags        = ["tag1", "tag2"]

  visibility_timeout_seconds = 30
  expire_seconds             = 345600
}
```

## Argument Reference

* `name` - (Required) キュー名
* `visibility_timeout_seconds` - (Optional) 可視性タイムアウトの秒数
* `expire_seconds` - (Optional) 未処理メッセージ保存期間の秒数
* `description` - (Optional) 説明
* `tags` - (Optional) タグ
* `icon_id` - (Optional) アイコンID

## Attribute Reference

* `id` - ID

