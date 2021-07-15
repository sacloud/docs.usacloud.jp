# アーカイブ: sakuracloud_archive

## Example Usage

```tf
# from archive/disk
resource "sakuracloud_archive" "from-archive-or-disk" {
  name         = "foobar"
  description  = "description"
  tags         = ["tag1", "tag2"]

  source_archive_id   = 123456789012
  source_archive_zone = "tk1a"
  # source_disk_id    = 123456789012
}

# from shared archive
resource "sakuracloud_archive" "from-shared-archive" {
  name         = "foobar"
  description  = "description"
  tags         = ["tag1", "tag2"]

  source_shared_key = "is1a:123456789012:xxx"
}


# from local file
resource "sakuracloud_archive" "foobar" {
  name         = "foobar"
  description  = "description"
  tags         = ["tag1", "tag2"]
  size         = 20
  archive_file = "test/dummy.raw"
}
```

<div class="editor">

<h2><a href="https://zouen-alpha.usacloud.jp/#resource/archive" target="_blank" rel="noopener noreferrer">Code Editor</a></h2>

<iframe src="https://zouen-alpha.usacloud.jp/#resource/archive"></iframe>

</div>

## Argument Reference

* `name` - (Required) 名前 / `1`-`64`文字で指定
* `archive_file` - (Optional) アップロードするファイルのパス
* `hash` - (Optional) アップロードするファイルをBASE64エンコードしたものから算出されたMD5チェックサム / この値を変更するとリソースの再作成が行われる
* `size` - (Optional) アーカイブのサイズ / 次のいずれかを指定［`20`/`40`/`60`/`80`/`100`/`250`/`500`/`750`/`1024`]  
この値を変更するとリソースの再作成が行われる / デフォルト:`20`
* `source_archive_id` - (Optional) コピー元アーカイブID / この値を変更するとリソースの再作成が行われる
* `source_archive_zone` - (Optional) コピー元アーカイブが属するゾーン名 / この値を変更するとリソースの再作成が行われる
* `source_disk_id` - (Optional) コピー元ディスクID / この値を変更するとリソースの再作成が行われる
* `source_shared_key` - (Optional) コピー元共有アーカイブの共有キー / この値を変更するとリソースの再作成が行われる


#### Common Arguments

* `description` - (Optional) 説明 / `1`-`512`文字で指定
* `icon_id` - (Optional) アイコンID
* `tags` - (Optional) タグ
* `zone` - (Optional) リソースを作成する対象ゾーンの名前(例: `is1a`, `tk1a`) / この値を変更するとリソースの再作成が行われる

#### Timeouts

`timeouts`ブロックで[カスタムタイムアウト](https://www.terraform.io/docs/configuration/resources.html#operation-timeouts)が設定可能です。  

* `create` - 作成 (デフォルト: 24時間)
* `update` - 更新 (デフォルト: 24時間)
* `delete` - 削除 (デフォルト: 5分)

## Attribute Reference

* `id` - ID



