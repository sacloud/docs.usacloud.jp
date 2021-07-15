# NFS: sakuracloud_nfs

## Example Usage

```tf
resource "sakuracloud_nfs" "foobar" {
  name = "foobar"
  plan = "ssd"
  size = "500"

  network_interface {
    switch_id   = sakuracloud_switch.foobar.id
    ip_address  = "192.168.11.101"
    netmask     = 24
    gateway     = "192.168.11.1"
  }

  description = "description"
  tags        = ["tag1", "tag2"]
}

resource "sakuracloud_switch" "foobar" {
  name = "foobar"
}
```

<div class="editor">

<h2><a href="https://zouen-alpha.usacloud.jp/#resource/nfs" target="_blank" rel="noopener noreferrer">Code Editor</a></h2>

<iframe src="https://zouen-alpha.usacloud.jp/#resource/nfs"></iframe>

</div>

## Argument Reference

* `name` - (Required) 名前 / `1`-`64`文字で指定
* `plan` - (Optional) ディスクプラン / 次のいずれかを指定［`hdd`/`ssd`]/ この値を変更するとリソースの再作成が行われる / デフォルト:`hdd`
* `size` - (Optional) ディスクサイズ(GiB単位) / この値を変更するとリソースの再作成が行われる / デフォルト:`100`

#### ネットワーク関連

* `network_interface` - (Required) ネットワーク設定。詳細は[network_interfaceブロック](#network_interface)を参照

##### network_interfaceブロック

* `switch_id` - (Required) スイッチID / この値を変更するとリソースの再作成が行われる
* `ip_address` - (Required) IPアドレス / この値を変更するとリソースの再作成が行われる
* `netmask` - (Required) サブネットマスク長 / `8`-`29`の範囲で指定 / この値を変更するとリソースの再作成が行われる
* `gateway` - (Optional) ゲートウェイIPアドレス / この値を変更するとリソースの再作成が行われる

#### Common Arguments

* `description` - (Optional) 説明 / `1`-`512`文字で指定
* `icon_id` - (Optional) アイコンID
* `tags` - (Optional) タグ
* `zone` - (Optional) リソースを作成する対象ゾーンの名前(例: `is1a`, `tk1a`) / この値を変更するとリソースの再作成が行われる

#### Timeouts

`timeouts`ブロックで[カスタムタイムアウト](https://www.terraform.io/docs/configuration/resources.html#operation-timeouts)が設定可能です。  

* `create` - 作成 (デフォルト: 24時間)
* `update` - 更新 (デフォルト: 24時間)
* `delete` - 削除 (デフォルト: 20分)

## Attribute Reference

* `id` - ID

