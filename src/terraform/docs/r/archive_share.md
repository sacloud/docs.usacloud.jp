# アーカイブ共有: sakuracloud_archive_share

## Example Usage

```tf
resource "sakuracloud_archive" "source" {
  name         = "foobar"
  size         = 20
  archive_file = "test/dummy.raw"
}

resource "sakuracloud_archive_share" "share_info" {
  archive_id = sakuracloud_archive.source.id
}
```

<div class="editor">

<h2><a href="https://zouen-alpha.usacloud.jp/#resource/archive_share" target="_blank" rel="noopener noreferrer">Code Editor</a></h2>

<iframe src="https://zouen-alpha.usacloud.jp/#resource/archive_share"></iframe>

</div>

## Argument Reference

* `archive_id` - (Required) アーカイブ共有を有効にするアーカイブのID / この値を変更するとリソースの再作成が行われる
* `zone` - (Optional) リソースを作成する対象ゾーンの名前(例: `is1a`, `tk1a`) / この値を変更するとリソースの再作成が行われる

#### Timeouts

`timeouts`ブロックで[カスタムタイムアウト](https://www.terraform.io/docs/configuration/resources.html#operation-timeouts)が設定可能です。  

* `create` - 作成 (デフォルト: 5分)
* `update` - 更新 (デフォルト: 5分)
* `delete` - 削除 (デフォルト: 5分)

## Attribute Reference

* `id` - ID
* `share_key` - 共有キー



