# NFS: sakuracloud_nfs

NFSの情報を参照するためのデータソース

## Example Usage

```tf
data "sakuracloud_nfs" "foobar" {
  filter {
    names = ["foobar"]
  }
}
```

<div class="editor">

<h2><a href="https://zouen-alpha.usacloud.jp/#data/nfs" target="_blank" rel="noopener noreferrer">Code Editor</a></h2>

<iframe src="https://zouen-alpha.usacloud.jp/#data/nfs"></iframe>

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
* `description` - 説明
* `icon_id` - アイコンID
* `name` - 名前
* `network_interface` - ネットワーク設定。詳細は[network_interfaceブロック](#network_interface)を参照
* `plan` - ディスクプラン。次のいずれかとなる［`hdd`/`ssd`]
* `size` - ディスクサイズ(GiB単位)
* `tags` - タグ

##### network_interfaceブロック

* `gateway` - ゲートウェイIPアドレス
* `ip_address` - IPアドレス
* `netmask` - サブネットマスク長
* `switch_id` - スイッチID


