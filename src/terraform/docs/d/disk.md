# ディスク: sakuracloud_disk

ディスクの情報を参照するためのデータソース

## Example Usage

```hcl
data "sakuracloud_disk" "foobar" {
  filter {
    names = ["foobar"]
  }
}
```

<div class="editor">

<h2>Code Editor</h2>

<iframe src="https://zouen-alpha.usacloud.jp/#data/disk"></iframe>

</div>

## Argument Reference

* `filter` - (Optional) 参照対象をフィルタリングするための条件。詳細は[filterブロック](#filter)を参照 
* `zone` - (Optional) 対象ゾーンの名前 (例: `is1a`, `tk1a`)  

##### filterブロック

* `condition` - (Optional) APIリクエスト時に利用されるフィルタリング用パラメータ。詳細は[conditionブロック](#condition)を参照  
* `id` - (Optional) 対象リソースのID 
* `names` - (Optional) 対象リソースの名前。指定値と部分一致するリソースが参照対象となる。複数指定した場合はAND条件となる  
* `tags` - (Optional) 対象リソースが持つタグ。指定値と完全一致するリソースが参照対象となる。複数指定した場合はAND条件となる

##### conditionブロック

* `name` - (Required) 対象フィールド名。大文字/小文字を区別する  
* `values` - (Required) 対象フィールドの値。複数指定した場合はAND条件となる

## Attribute Reference

* `id` - ID
* `connector` - ディスク接続インターフェース。 次のいずれかとなる［`virtio`/`ide`]
* `description` - 説明
* `icon_id` - アイコンID
* `name` - 名称
* `plan` - プラン。 次のいずれかとなる［`ssd`/`hdd`]
* `server_id` - ディスクが接続されたサーバのID
* `size` - サイズ(GiB)
* `source_archive_id` - コピー元アーカイブID
* `source_disk_id` - コピー元ディスクID
* `tags` - タグ



