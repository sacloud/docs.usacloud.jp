# 専有ホスト: sakuracloud_private_host

## Example Usage

```hcl
resource "sakuracloud_private_host" "foobar" {
  name        = "foobar"
  description = "description"
  tags        = ["tag1", "tag2"]
}
```

<div class="editor">

<h2>Code Editor</h2>

<iframe src="https://zouen-alpha.usacloud.jp/#resource/private_host"></iframe>

</div>


## Argument Reference

* `name` - (Required) 名前 / `1`-`64`文字で指定
* `class` - (Optional) クラス / 次のいずれかを指定［`dynamic`/`ms_windows`]/ デフォルト:`dynamic`

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
* `assigned_core` - サーバに割り当てたCPUコアの総数
* `assigned_memory` - サーバに割り当てたメモリ(GiB単位)の総数
* `hostname` - ホスト名
