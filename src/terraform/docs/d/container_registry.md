# コンテナレジストリ: sakuracloud_container_registry

コンテナレジストリの情報を参照するためのデータソース

## Example Usage

```hcl
data "sakuracloud_container_registry" "foobar" {
  filter {
    names = ["foobar"]
  }
}
```

<div class="editor">

<h2>Code Editor</h2>

<iframe src="https://zouen-alpha.usacloud.jp/#data/container_registry"></iframe>

</div>

## Argument Reference

* `filter` - (Optional) 参照対象をフィルタリングするための条件。詳細は[filterブロック](#filter)を参照 

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
* `access_level` - アクセスレベル。ユーザーがコンテナレジストリにアクセスできる操作のレベルを表す  
次のいずれかの値となる。[`readwrite`/`readonly`/`none`]
* `description` - 説明
* `fqdn` - コンテナレジストリにアクセスするためのFQDN
* `icon_id` - アイコンID
* `name` - 名前
* `subdomain_label` - コンテナレジストリにアクセスするためのFQDNのラベル  
`subdomain_label` + `.sakuracr.jp`がFQDNとなる  
* `tags` - タグ
* `user` - ユーザー情報。詳細は[userブロック](#user)を参照
* `virtual_domain` - 独自ドメイン(FQDN)

#### userブロック

* `name` - ユーザー名
* `permission` - ユーザーの権限。次のいずれかとなる［`all`/`readwrite`/`readonly`]


