# データベースアプライアンス: sakuracloud_database

## Example Usage

```tf
variable username {}
variable password {}
variable replica_password {}

resource "sakuracloud_database" "foobar" {
  name          = "foobar"
  database_type = "mariadb"
  plan          = "30g"

  username = var.username
  password = var.password

  replica_password = var.replica_password

  network_interface {
    switch_id     = sakuracloud_switch.foobar.id
    ip_address    = "192.168.11.11"
    netmask       = 24
    gateway       = "192.168.11.1"
    port          = 3306
    source_ranges = ["192.168.11.0/24", "192.168.12.0/24"]
  }

  backup {
    time     = "00:00"
    weekdays = ["mon", "tue"]
  }
  
  parameters = {
    max_connections = 100
  }

  description = "description"
  tags        = ["tag1", "tag2"]
}

resource "sakuracloud_switch" "foobar" {
  name = "foobar"
}
```

<div class="editor">

<h2><a href="https://zouen-alpha.usacloud.jp/#resource/database" target="_blank" rel="noopener noreferrer">Code Editor</a></h2>

<iframe src="https://zouen-alpha.usacloud.jp/#resource/database"></iframe>

</div>

## Argument Reference

* `name` - (Required) 名前 / `1`-`64`文字で指定
* `database_type` - (Optional) データベースタイプ / 次のいずれかを指定［`mariadb`/`postgres`]/ この値を変更するとリソースの再作成が行われる / デフォルト:`postgres`.
* `plan` - (Optional) プラン / 次のいずれかを指定［`10g`/`30g`/`90g`/`240g`/`500g`/`1t`]/  この値を変更するとリソースの再作成が行われる / デフォルト:`10g`.

#### ユーザー関連

* `username` - (Required) デフォルトユーザー名 / `3`-`20`文字で指定 / この値を変更するとリソースの再作成が行われる
* `password` - (Required) デフォルトユーザーのパスワード

#### ネットワーク関連

* `network_interface` - (Required) ネットワーク設定。詳細は[network_interfaceブロック](#network_interface)を参照

##### network_interfaceブロック

* `switch_id` - (Required) スイッチID /  この値を変更するとリソースの再作成が行われる
* `gateway` - (Required) ゲートウェイIPアドレス / この値を変更するとリソースの再作成が行われる
* `ip_address` - (Required) IPアドレス / この値を変更するとリソースの再作成が行われる
* `netmask` - (Required) サブネットマスク長 /  `8`-`29`の範囲で指定 /  この値を変更するとリソースの再作成が行われる
* `port` - (Optional) ポート番号 / `1024`-`65535`の範囲で指定 / デフォルト:`5432`
* `source_ranges` - (Optional) データベースアプライアンスにアクセスできるIPアドレス、またはCIDRブロックのリスト

#### バックアップ関連

* `backup` - (Optional) バックアップ設定。詳細は[backupブロック](#backup)を参照

##### backupブロック

* `time` - (Optional) バックアップ取得時刻 / `HH:mm`形式で指定
* `weekdays` - (Optional) バックアップ取得曜日のリスト / 各要素は次のいずれかを指定［`sun`/`mon`/`tue`/`wed`/`thu`/`fri`/`sat`]

#### RDBMS固有パラメータ関連

* `parameters` - RDBMS固有のパラメータ設定のマップ。指定可能なキーの一覧は`usacloud database list-parameters <ID or Name or Tags>`コマンドで参照可能

#### レプリケーション関連

* `replica_password` - (Optional) レプリケーションユーザーのパスワード
* `replica_user` - (Optional) レプリケーションユーザー名 / デフォルト:`replica`

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
$ terraform import sakuracloud_database.example 123456789012
```