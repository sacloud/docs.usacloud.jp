# SIM: sakuracloud_sim

## Example Usage

```tf
resource "sakuracloud_sim" "foobar" {
  name        = "foobar"
  description = "description"
  tags        = ["tag1", "tag2"]

  iccid    = "your-iccid"
  passcode = "your-password"
  #imei     = "your-imei"
  carrier = ["softbank", "docomo", "kddi"]

  enabled = true
}
```

<div class="editor">

<h2><a href="https://zouen-alpha.usacloud.jp/#resource/sim" target="_blank" rel="noopener noreferrer">Code Editor</a></h2>

<iframe src="https://zouen-alpha.usacloud.jp/#resource/sim"></iframe>

</div>


## Argument Reference

* `name` - (Required) 名前 / `1`-`64`文字で指定
* `enabled` - (Optional) 有効フラグ / デフォルト:`true`

#### 登録関連

* `iccid` - (Required) ICCID(Integrated Circuit Card ID) / この値を変更するとリソースの再作成が行われる
* `passcode` - (Required) パスコード / この値を変更するとリソースの再作成が行われる
* `carrier` - (Required) 利用するキャリアのリスト / 各要素は次のいずれかを指定［`kddi`/`docomo`/`softbank`]

#### IMEIロック

* `imei` - (Optional) IMEIロックを利用する場合のIMEI

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
* `ip_address` - SIMに割り当てられたIPアドレス
* `mobile_gateway_id` - モバイルゲートウェイのID


## Import

IDを指定する事でインポート可能です。

```bash
$ terraform import sakuracloud_sim.example 123456789012
```