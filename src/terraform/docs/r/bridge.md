# ブリッジ: sakuracloud_bridge

## Example Usage

```tf
resource "sakuracloud_switch" "is1a" {
  name        = "is1a"
  description = "description"
  bridge_id   = sakuracloud_bridge.foobar.id
  zone        = "is1a"
}

resource "sakuracloud_switch" "is1b" {
  name        = "is1b"
  description = "description"
  bridge_id   = sakuracloud_bridge.foobar.id
  zone        = "is1b"
}

resource "sakuracloud_bridge" "foobar" {
  name        = "foobar"
  description = "description"
}
```

<div class="editor">

<h2><a href="https://zouen-alpha.usacloud.jp/#resource/bridge" target="_blank" rel="noopener noreferrer">Code Editor</a></h2>

<iframe src="https://zouen-alpha.usacloud.jp/#resource/bridge"></iframe>

</div>


## Argument Reference

* `name` - (Required) 名前 / `1`-`64`文字で指定

#### Common Arguments

* `description` - (Optional) 説明 / `1`-`512`文字で指定
* `zone` - (Optional) リソースを作成する対象ゾーンの名前(例: `is1a`, `tk1a`) / この値を変更するとリソースの再作成が行われる

#### Timeouts

`timeouts`ブロックで[カスタムタイムアウト](https://www.terraform.io/docs/configuration/resources.html#operation-timeouts)が設定可能です。  

* `create` - 作成 (デフォルト: 20分)
* `update` - 更新 (デフォルト: 20分)
* `delete` - 削除 (デフォルト: 20分)

## Attribute Reference

* `id` - ID

## Import

IDを指定する事でインポート可能です。

```bash
$ terraform import sakuracloud_bridge.example 123456789012
```