# オートスケール: sakuracloud_auto_scale

## Example Usage

```tf
locals {
  zone               = "is1a"
  server_name_prefix = "target-server-"
  api_key_id         = "<your-api-key>"
}

resource "sakuracloud_auto_scale" "foobar" {
  name  = "example"
  zones = [local.zone]

  config = jsonencode({
    resources : [{
      type : "Server",
      selector : {
        names : [sakuracloud_server.foobar.name],
        zones : [local.zone],
      },
    }],
  })

  api_key_id = local.api_key_id

  cpu_threshold_scaling {
    server_prefix = local.server_name_prefix
    up            = 80
    down          = 20
  }
}

resource "sakuracloud_server" "foobar" {
  name = local.server_name_prefix
  force_shutdown = true
  zone = local.zone
}
```

<div class="editor">

<h2><a href="https://zouen-alpha.usacloud.jp/#resource/auto_scale" target="_blank" rel="noopener noreferrer">Code Editor</a></h2>

<iframe src="https://zouen-alpha.usacloud.jp/#resource/auto_scale"></iframe>

</div>


## Argument Reference

* `name` -  (Required) 名前 / `1`-`64`文字で指定
* `api_key_id` - (Required) APIキーのID / この値を変更するとリソースの再作成が行われる
* `config` - (Required) sacloud/autoscalerの設定ファイル
* `cpu_threshold_scaling` - (Required) スケール動作の閾値。詳細は[cpu_threshold_scalingブロック](#cpu_threshold_scaling)を参照
* `zones` - (Required) 監視対象が存在するゾーン名のリスト

#### `cpu_threshold_scaling`ブロック

* `server_prefix` - (Required) 監視対象のサーバ名のプリフィックス
* `up` - (Required) 性能アップするCPU使用率
* `down` - (Required) 性能ダウンするCPU使用率


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

## Import

IDを指定する事でインポート可能です。

```bash
$ terraform import sakuracloud_auto_scale.example 123456789012
```
