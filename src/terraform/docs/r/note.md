# スタートアップスクリプト: sakuracloud_note

## Example Usage

```tf
resource "sakuracloud_note" "foobar" {
  name    = "foobar"
  content = file("startup-script.sh")
}
```

<div class="editor">

<h2><a href="https://zouen-alpha.usacloud.jp/#resource/note" target="_blank" rel="noopener noreferrer">Code Editor</a></h2>

<iframe src="https://zouen-alpha.usacloud.jp/#resource/note"></iframe>

</div>


## Argument Reference

* `name` - (Required) 名前 / `1`-`64`文字で指定
* `content` - (Required) スタートアップスクリプトのコンテンツ / シェルスクリプト、またはyamlとなる
* `class` - (Optional) クラス / 次のいずれかを指定［`shell`/`yaml_cloud_config`]/ デフォルト:`shell`

#### Common Arguments

* `icon_id` - (Optional) アイコンID
* `tags` - (Optional) タグ

#### Timeouts

`timeouts`ブロックで[カスタムタイムアウト](https://www.terraform.io/docs/configuration/resources.html#operation-timeouts)が設定可能です。  

* `create` - 作成 (デフォルト: 5分)
* `update` - 更新 (デフォルト: 5分)
* `delete` - 削除 (デフォルト: 5分)

## Attribute Reference

* `id` - ID
* `description` - 説明 / `content`内に設定した値から算出される

## Import

IDを指定する事でインポート可能です。

```bash
$ terraform import sakuracloud_note.example 123456789012
```
