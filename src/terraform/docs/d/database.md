# データベース: sakuracloud_database

データベースの情報を参照するためのデータソース

## Example Usage

```hcl
data "sakuracloud_database" "foobar" {
  filter {
    names = ["foobar"]
  }
}
```

<div class="editor">

<h2>Code Editor</h2>

<iframe src="https://zouen-alpha.usacloud.jp/#data/database"></iframe>

</div>

## Argument Reference

* `filter` - (Optional) 参照対象をフィルタリングするための条件。詳細は[filterブロック](#filter)を参照 
* `zone` - (Optional) 対象ゾーンの名前 (例: `is1a`, `tk1a`)  

##### filterブロック

* `condition` - (Optional) APIリクエスト時に利用されるフィルタリング用パラメータ。詳細は[conditionブロック](#condition)を参照  
* `id` - (Optional) 対象リソースのID 
* `names` - (Optional) 対象リソースの名前。指定値と部分一致するリソースが参照対象となる。複数指定した場合はAND条件となる  
* `tags` - (Optional) 対象リソースが持つタグ。指定値と完全一致するリソースが参照対象となる。複数指定した場合はAND条件となる

##### conditionブロック

* `name` - (Required) 対象フィールド名。大文字/小文字を区別する  
* `values` - (Required) 対象フィールドの値。複数指定した場合はAND条件となる


## Attribute Reference

* `id` - ID
* `backup` - バックアップ設定。詳細は[backupブロック](#backup)を参照
要素は次のいずれかとなる［`sun`/`mon`/`tue`/`wed`/`thu`/`fri`/`sat`]
* `database_type` - データベース種別。 次のいずれかとなる［`mariadb`/`postgres`]
* `description` - 説明
* `icon_id` - アイコンID
* `name` - 名前
* `network_interface` - ネットワーク設定。詳細は[network_interfaceブロック](#network_interface)を参照
* `parameters` - RDBMS固有のパラメータ設定のマップ  
* `password` - デフォルトユーザーのパスワード
* `plan` - プラン。次のいずれかとなる［`10g`/`30g`/`90g`/`240g`/`500g`/`1t`].
* `replica_password` - レプリケーションユーザーのパスワード
* `replica_user` - レプリケーションユーザー名
* `tags` - タグ
* `username` - デフォルトユーザー名

##### backupブロック

* `time` - バックアップ開始時刻。`HH:mm`形式
* `weekdays` - バックアップを取得する曜日のリスト  

##### network_interfaceブロック

* `gateway` - ゲートウェイのIPアドレス
* `ip_address` - IPアドレス
* `netmask` - サブネットマスク長
* `port` - ポート番号
* `source_ranges` - データベースへのアクセスを許可するソースIP範囲のリスト
* `switch_id` - スイッチID
