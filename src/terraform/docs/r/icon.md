# アイコン: sakuracloud_icon

## Example Usage

```hcl
resource "sakuracloud_icon" "foobar" {
  name = "foobar"
  tags = ["tag1", "tag2"]

  base64content = filebase64("example.icon")
}
```

<div class="editor">

<h2>Code Editor</h2>

<iframe src="https://zouen-alpha.usacloud.jp/#resource/icon"></iframe>

</div>


## Argument Reference

* `name` - (Required) 名前 / `1`-`64`文字で指定
* `base64content` - (Optional) base64エンコードされたコンテンツ /[`source`]と同時に指定できません / この値を変更するとリソースの再作成が行われる
* `source` - (Optional) アップロードするアイコンファイルのパス /[`base64content`]と同時に指定できません / この値を変更するとリソースの再作成が行われる
* `tags` - (Optional) タグ

#### Timeouts

`timeouts`ブロックで[カスタムタイムアウト](https://www.terraform.io/docs/configuration/resources.html#operation-timeouts)が設定可能です。  

* `create` - 作成 (デフォルト: 5分)
* `update` - 更新 (デフォルト: 5分)
* `delete` - 削除 (デフォルト: 5分)

## Attribute Reference

* `id` - ID
* `url` - アイコンのデータを取得するためのURL

