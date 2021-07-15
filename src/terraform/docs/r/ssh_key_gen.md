# SSH公開鍵(生成): sakuracloud_ssh_key_gen

## Example Usage

```tf
resource "sakuracloud_ssh_key_gen" "foobar" {
  name = "foobar"
  #pass_phrase = "your-pass-phrase"
  description = "description"
}
```

<div class="editor">

<h2><a href="https://zouen-alpha.usacloud.jp/#resource/ssh_key_gen" target="_blank" rel="noopener noreferrer">Code Editor</a></h2>

<iframe src="https://zouen-alpha.usacloud.jp/#resource/ssh_key_gen"></iframe>

</div>

## Argument Reference

* `name` - (Required) 名前 / `1`-`64`文字で指定 / この値を変更するとリソースの再作成が行われる
* `pass_phrase` - (Optional) 秘密鍵のパスフレーズ / `8`-`64`文字で指定 / この値を変更するとリソースの再作成が行われる

#### Common Arguments

* `description` - (Optional) 説明 / `1`-`512`文字で指定

#### Timeouts

`timeouts`ブロックで[カスタムタイムアウト](https://www.terraform.io/docs/configuration/resources.html#operation-timeouts)が設定可能です。  

* `create` - 作成 (デフォルト: 5分)
* `delete` - 削除 (デフォルト: 5分)

## Attribute Reference

* `id` - ID
* `fingerprint` - 公開鍵のフィンガープリント
* `private_key` - 秘密鍵
* `public_key` - 公開鍵

