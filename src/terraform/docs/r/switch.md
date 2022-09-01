# スイッチ: sakuracloud_switch

## Example Usage

```tf
resource "sakuracloud_switch" "foobar" {
  name        = "foobar"
  description = "description"
  tags        = ["tag1", "tag2"]
}
```

<div class="editor">

<h2><a href="https://zouen-alpha.usacloud.jp/#resource/switch" target="_blank" rel="noopener noreferrer">Code Editor</a></h2>

<iframe src="https://zouen-alpha.usacloud.jp/#resource/switch"></iframe>

</div>

## Argument Reference

* `name` - (Required) 名前 / `1`-`64`文字で指定
* `bridge_id` - (Optional) 接続するブリッジのID

#### Common Arguments

* `description` - (Optional) 説明 / `1`-`512`文字で指定
* `icon_id` - (Optional) アイコンID
* `tags` - (Optional) タグ
* `zone` - (Optional) リソースを作成する対象ゾーンの名前(例: `is1a`, `tk1a`) / この値を変更するとリソースの再作成が行われる

#### Timeouts

`timeouts`ブロックで[カスタムタイムアウト](https://www.terraform.io/docs/configuration/resources.html#operation-timeouts)が設定可能です。  

* `create` - 作成 (デフォルト: 5分)
* `update` - 更新 (デフォルト: 5分)
* `delete` - 削除 (デフォルト: 20分)

## Attribute Reference

* `id` - ID
* `server_ids` - スイッチに接続されているサーバのIDのリスト


## Import

IDを指定する事でインポート可能です。

```bash
$ terraform import sakuracloud_switch.example 123456789012
```