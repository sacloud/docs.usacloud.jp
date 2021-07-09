# ディスク: sakuracloud_disk

## Example Usage

```hcl
data "sakuracloud_archive" "ubuntu" {
  os_type = "ubuntu"
}

resource "sakuracloud_disk" "foobar" {
  name              = "foobar"
  plan              = "ssd"
  connector         = "virtio"
  size              = 20
  source_archive_id = data.sakuracloud_archive.ubuntu.id
  #distant_from      = ["111111111111"]

  description = "description"
  tags        = ["tag1", "tag2"]
}
```

<div class="editor">

<h2>Code Editor</h2>

<iframe src="https://zouen-alpha.usacloud.jp/#resource/disk"></iframe>

</div>


## Argument Reference

* `name` - (Required) 名前 / `1`-`64`文字で指定

#### スペック関連

* `connector` - (Optional) ディスク接続インターフェース / 次のいずれかを指定［`virtio`/`ide`]/ この値を変更するとリソースの再作成が行われる / デフォルト:`virtio`
* `plan` - (Optional) ディスクプラン / 次のいずれかを指定［`ssd`/`hdd`]/ この値を変更するとリソースの再作成が行われる / デフォルト:`ssd`
* `size` - (Optional) サイズ(GiB単位) / この値を変更するとリソースの再作成が行われる / デフォルト:`20`
* `distant_from` - (Optional) 別のストレージに格納する対象となるディスクのIDのリスト / この値を変更するとリソースの再作成が行われる

!!! Note
    1TB以上のサイズを指定する場合、`size`に1024の倍数を指定してください。  
    `size = 2 * 1024` (2TBの例)

#### コピー元関連

* `source_archive_id` - (Optional) コピー元アーカイブID /[`source_disk_id`]と同時に指定できません / この値を変更するとリソースの再作成が行われる
* `source_disk_id` - (Optional) コピー元ディスクID /[`source_archive_id`]と同時に指定できません / この値を変更するとリソースの再作成が行われる

#### Common Arguments

* `description` - (Optional) 説明 / `1`-`512`文字で指定
* `icon_id` - (Optional) アイコンID
* `tags` - (Optional) タグ
* `zone` - (Optional) リソースを作成する対象ゾーンの名前(例: `is1a`, `tk1a`) / この値を変更するとリソースの再作成が行われる

#### Timeouts

`timeouts`ブロックで[カスタムタイムアウト](https://www.terraform.io/docs/configuration/resources.html#operation-timeouts)が設定可能です。  

* `create` - 作成 (デフォルト: 24時間)
* `update` - 更新 (デフォルト: 24時間)
* `delete` - 削除 (デフォルト: 20分)

## Attribute Reference

* `id` - ID
* `server_id` - このディスクが接続されたサーバのID

