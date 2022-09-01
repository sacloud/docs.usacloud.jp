# SSH公開鍵: sakuracloud_ssh_key

## Example Usage

```tf
resource "sakuracloud_ssh_key" "foobar" {
  name       = "foobar"
  public_key = file("~/.ssh/id_rsa.pub")
}
```

<div class="editor">

<h2><a href="https://zouen-alpha.usacloud.jp/#resource/ssh_key" target="_blank" rel="noopener noreferrer">Code Editor</a></h2>

<iframe src="https://zouen-alpha.usacloud.jp/#resource/ssh_key"></iframe>

</div>


## Argument Reference

* `name` - (Required) 名前 / `1`-`64`文字で指定
* `public_key` - (Required) 公開鍵 / この値を変更するとリソースの再作成が行われる

#### Common Arguments

* `description` - (Optional) 説明 / `1`-`512`文字で指定

#### Timeouts

`timeouts`ブロックで[カスタムタイムアウト](https://www.terraform.io/docs/configuration/resources.html#operation-timeouts)が設定可能です。  

* `create` - 作成 (デフォルト: 5分)
* `update` - 更新 (デフォルト: 5分)
* `delete` - 削除 (デフォルト: 5分)

## Attribute Reference

* `id` - ID
* `fingerprint` - 公開鍵のフィンガープリント

## Import

IDを指定する事でインポート可能です。

```bash
$ terraform import sakuracloud_ssh_key.example 123456789012
```