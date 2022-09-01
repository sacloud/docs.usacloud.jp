# データベースアプライアンス(リードレプリカ): sakuracloud_database_read_replica

## Example Usage

```tf
resource "sakuracloud_database_read_replica" "foobar" {
  master_id    = data.sakuracloud_database.master.id
  network_interface {
    ip_address   = "192.168.11.111"
  }
  name         = "foobar"
  description  = "description"
  tags         = ["tag1", "tag2"]
}

data sakuracloud_database "master" {
  filter {
    names = ["master-database-name"]
  }
}
```

<div class="editor">

<h2><a href="https://zouen-alpha.usacloud.jp/#resource/database_read_replica" target="_blank" rel="noopener noreferrer">Code Editor</a></h2>

<iframe src="https://zouen-alpha.usacloud.jp/#resource/database_read_replica"></iframe>

</div>


## Argument Reference

* `name` - (Required) 名前 / `1`-`64`文字で指定
* `master_id` - (Required) レプリケーションのマスターとなるデータベースアプライアンスのID /  この値を変更するとリソースの再作成が行われる

#### Network関連

- `network_interface` - ネットワーク設定。詳細は[network_interfaceブロック](#network_interface)を参照

##### network_interfaceブロック

* `ip_address` - (Required) IPアドレス / この値を変更するとリソースの再作成が行われる
* `gateway` - (Optional) ゲートウェイIPアドレス / 未指定の場合マスターデータベースの値が利用されます / この値を変更するとリソースの再作成が行われる
* `netmask` - (Optional) サブネットマスク長 / `8`-`29`の範囲で指定 / 未指定の場合マスターデータベースの値が利用されます / この値を変更するとリソースの再作成が行われる
* `switch_id` - (Optional) スイッチID / 未指定の場合マスターデータベースの値が利用されます / この値を変更するとリソースの再作成が行われる
* `source_ranges` - (Optional) データベースアプライアンスにアクセスできるIPアドレス、またはCIDRブロックのリスト

#### Common Arguments

* `description` - (Optional) 説明 / `1`-`512`文字で指定
* `icon_id` - (Optional) アイコンID
* `tags` - (Optional) タグ
* `zone` - (Optional) リソースを作成する対象ゾーンの名前(例: `is1a`, `tk1a`) / この値を変更するとリソースの再作成が行われる

#### Timeouts

`timeouts`ブロックで[カスタムタイムアウト](https://www.terraform.io/docs/configuration/resources.html#operation-timeouts)が設定可能です。  

* `create` - 作成 (デフォルト: 60分)
* `update` - 更新 (デフォルト: 60分)
* `delete` - 削除 (デフォルト: 20分)

## Attribute Reference

* `id` - ID
 
## Import

IDを指定する事でインポート可能です。

```bash
$ terraform import sakuracloud_database_read_replica.example 123456789012
```