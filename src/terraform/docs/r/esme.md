# 2要素認証SMS(ESME): sakuracloud_esme

## Example Usage

```tf
resource "sakuracloud_esme" "foobar" {
  name        = "foobar"
  description = "description"
  tags        = ["tag1", "tag2"]
}
```

<div class="editor">

<h2><a href="https://zouen-alpha.usacloud.jp/#resource/esme" target="_blank" rel="noopener noreferrer">Code Editor</a></h2>

<iframe src="https://zouen-alpha.usacloud.jp/#resource/esme"></iframe>

</div>


## Argument Reference

* `name` - (Required) 名前 / `1`-`64`文字で指定

#### Common Arguments

* `description` - (Optional) 説明 / `1`-`512`文字で指定
* `icon_id` - (Optional) アイコンID
* `tags` - (Optional) タグ

#### Timeouts

`timeouts`ブロックで[カスタムタイムアウト](https://www.terraform.io/docs/configuration/resources.html#operation-timeouts)が設定可能です。  

* `create` - 作成 (デフォルト: 5分)
* `update` - 更新 (デフォルト: 5分)
* `delete` - 削除 (デフォルト: 5分)

## Attribute Reference

* `id` - ID
* `send_message_with_generated_otp_api_url` - SMS送信(OTP自動生成)APIのURL
* `send_message_with_inputted_otp_api_url` - SMS送信(OTP入力)APIのURL

