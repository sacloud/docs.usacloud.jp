# シンプルMQ: sakuracloud_simple_mq

シンプルMQの情報を参照するためのデータソース

## Example Usage

```tf
data "sakuracloud_simple_mq" "foobar" {
  name = "foobar"
}
```

## Argument Reference

nameもしくはtagsのいずれかを指定し、当てはまるキューが一意に定まる必要があります。

* `name` - (Optional) キュー名
* `tags` - (Optional) 対象リソースが持つタグ。指定値と完全一致するリソースが参照対象となる。複数指定した場合はAND条件となる

## Attribute Reference

* `id` - ID
* `name` - キュー名
* `visibility_timeout_seconds` - 可視性タイムアウトの秒数
* `expire_seconds` - 未処理メッセージ保存期間の秒数
* `description` - 説明
* `tags` - タグ
* `icon_id` - アイコンID

