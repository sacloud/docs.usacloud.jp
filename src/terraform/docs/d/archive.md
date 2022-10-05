# アーカイブ: sakuracloud_archive

アーカイブの情報を参照するためのデータソース

## Example Usage

```tf
data "sakuracloud_archive" "foobar" {
  os_type = "centos"
}
```

<div class="editor">

<h2><a href="https://zouen-alpha.usacloud.jp/#data/archive" target="_blank" rel="noopener noreferrer">Code Editor</a></h2>

<iframe src="https://zouen-alpha.usacloud.jp/#data/archive"></iframe>

</div>

## Argument Reference

* `filter` - (Optional) 参照対象をフィルタリングするための条件。詳細は[filterブロック](#filter)を参照  
* `os_type` - (Optional) 最新安定板のパブリックアーカイブを参照する。    
    * **CentOS**:[`centos`/`centos7`]
    * **AlmaLinux**:[`almalinux`/`almalinux8`/`almalinux9`]
    * **RockyLinux**:[`rockylinux`/`rockylinux8`/`rockylinux9`]
    * **MIRACLE LINUX**:[`miracle`/`miraclelinux`/`miracle8`/`miraclelinux8`]
    * **Ubuntu**:[`ubuntu`/`ubuntu2204`/`ubuntu2004`/`ubuntu1804`]
    * **Debian**:[`debian`/`debian10`/`debian11`]
    * **Kusanagi**: `kusanagi`

* `zone` - (Optional) 対象ゾーンの名前 (例: `is1a`, `tk1a`)  

##### filterブロック

* `condition` - (Optional) APIリクエスト時に利用されるフィルタリング用パラメータ。詳細は[conditionブロック](#condition)を参照  
* `id` - (Optional) 対象リソースのID 
* `names` - (Optional) 対象リソースの名前。指定値と部分一致するリソースが参照対象となる。複数指定した場合はAND条件となる  
* `tags` - (Optional) 対象リソースが持つタグ。指定値と完全一致するリソースが参照対象となる。複数指定した場合はAND条件となる

##### conditionブロック

* `name` - (Required) 対象フィールド名。大文字/小文字を区別する  
* `values` - (Required) 対象フィールドの値。複数指定した場合はAND条件となる

指定可能なフィールド名については[さくらのクラウド APIドキュメント](https://developer.sakura.ad.jp/cloud/api/1.1/)を参照してください。  

## Attribute Reference

* `id` - ID
* `description` - 説明
* `icon_id` - アイコンID
* `name` - 名前
* `size` - サイズ(単位:GiB)
* `tags` - タグ



