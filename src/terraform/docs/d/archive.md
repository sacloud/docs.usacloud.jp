# アーカイブ: sakuracloud_archive

アーカイブの情報を参照するためのデータソース

## Example Usage

```hcl
data "sakuracloud_archive" "foobar" {
  os_type = "centos8"
}
```

<div class="editor">

<h2>Code Editor</h2>

<iframe src="https://zouen-alpha.usacloud.jp/#data/archive"></iframe>

</div>

## Argument Reference

* `filter` - (Optional) 参照対象をフィルタリングするための条件。詳細は[filterブロック](#filter)を参照  
* `os_type` - (Optional) 最新安定板のパブリックアーカイブを参照する。    
    - **CentOS**: [`centos`/`centos8`/`centos8stream`/`centos7`/`centos6`]  
    - **Ubuntu**: [`ubuntu`/`ubuntu2004`/`ubuntu1804`/`ubuntu1604`]  
    - **Debian**: [`debian`/`debian10`/`debian9`]
    - **CoreOS/ContainerLinux**: `coreos`  
    - **RancherOS**: `rancheros`  
    - **k3OS**: `k3os`  
    - **FreeBSD**: `freebsd`  
    - **Kusanagi**: `kusanagi`
    - **Windows2016**: [`windows2016`/`windows2016-rds`/`windows2016-rds-office`]
    - **Windows2016+SQLServer**:  [`windows2016-sql-web`/`windows2016-sql-standard`/`windows2016-sql-standard-all`]  
    - **Windows2016+SQLServer2017**: [`windows2016-sql2017-standard`/`windows2016-sql2017-enterprise`/`windows2016-sql2017-standard-all`]  
    - **Windows2019**: [`windows2019`/`windows2019-rds`/`windows2019-rds-office2016`/`windows2019-rds-office2019`]  
    - **Windows2019+SQLServer2017**: [`windows2019-sql2017-web`/`windows2019-sql2017-standard`/`windows2019-sql2017-enterprise`/`windows2019-sql2017-standard-all`]  
    - **Windows2019+SQLServer2019**: [`windows2019-sql2019-web`/`windows2019-sql2019-standard`/`windows2019-sql2019-enterprise`/`windows2019-sql2019-standard-all`]  
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



