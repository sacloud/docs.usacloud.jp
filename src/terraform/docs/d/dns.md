# DNS: sakuracloud_dns

DNSの情報を参照するためのデータソース

## Example Usage

```hcl
data "sakuracloud_dns" "foobar" {
  filter {
    names = ["foobar"]
  }
}
```

<div class="editor">

<h2>Code Editor</h2>

<iframe src="https://zouen-alpha.usacloud.jp/#data/dns"></iframe>

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
* `description` - 説明
* `dns_servers` - このゾーンを管理するDNSサーバのIPアドレスのリスト
* `icon_id` - アイコンID
* `record` - レコードのリスト。詳細は[recordブロック](#record)を参照  
* `tags` - タグ
* `zone` - 管理対象のドメイン名

##### recordブロック

* `name` - 名前
* `port` - ポート番号
* `priority` - プライオリティ
* `ttl` - TTL
* `type` - レコード種別。次のいずれかとなる［`A`/`AAAA`/`ALIAS`/`CNAME`/`NS`/`MX`/`TXT`/`SRV`/`CAA`/`PTR`]
* `value` - 値
* `weight` - ウェイト


