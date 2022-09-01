# 自動バックアップ: sakuracloud_auto_backup

## Example Usage

```tf
resource "sakuracloud_disk" "foobar" {
  name = "foobar"
}
resource "sakuracloud_auto_backup" "foobar" {
  name           = "foobar"
  disk_id        = sakuracloud_disk.foobar.id
  weekdays       = ["mon", "tue", "wed", "thu", "fri", "sat", "sun"]
  max_backup_num = 5
  description    = "description"
  tags           = ["tag1", "tag2"]
}
```

<div class="editor">

<h2><a href="https://zouen-alpha.usacloud.jp/#resource/auto_backup" target="_blank" rel="noopener noreferrer">Code Editor</a></h2>

<iframe src="https://zouen-alpha.usacloud.jp/#resource/auto_backup"></iframe>

</div>


## Argument Reference

* `name` -  (Required) 名前 / `1`-`64`文字で指定
* `disk_id` - (Required) バックアップ対象のディスクID / この値を変更するとリソースの再作成が行われる
* `weekdays` - (Required) バックアップ取得曜日のリスト / 各要素は次のいずれかを指定［`sun`/`mon`/`tue`/`wed`/`thu`/`fri`/`sat`]
* `max_backup_num` - (Optional) バックアップ数 / `1`-`10`の範囲で指定 / デフォルト:`1`

#### Common Arguments

* `description` - (Optional) 説明 / `1`-`512`文字で指定
* `icon_id` - (Optional) アイコンID
* `tags` - (Optional) タグ
* `zone` - (Optional) リソースを作成する対象ゾーンの名前(例: `is1a`, `tk1a`) / この値を変更するとリソースの再作成が行われる

#### Timeouts

`timeouts`ブロックで[カスタムタイムアウト](https://www.terraform.io/docs/configuration/resources.html#operation-timeouts)が設定可能です。  

* `create` - 作成 (デフォルト: 5分)
* `update` - 更新 (デフォルト: 5分)
* `delete` - 削除 (デフォルト: 5分)

## Attribute Reference

* `id` - ID

## Import

IDを指定する事でインポート可能です。

```bash
$ terraform import sakuracloud_auto_backup.example 123456789012
```
