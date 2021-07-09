# パケットフィルタ : sakuracloud_packet_filter

パケットフィルタの情報を参照するためのデータソース

## Example Usage

```hcl
data "sakuracloud_packet_filter" "foobar" {
  filter {
    names = ["foobar"]
  }
}
```

<div class="editor">

<h2>Code Editor</h2>

<iframe src="https://zouen-alpha.usacloud.jp/#data/packet_filter"></iframe>

</div>


## Argument Reference

* `filter` - (Optional) 参照対象をフィルタリングするための条件。詳細は[filterブロック](#filter)を参照 
* `zone` - (Optional) 対象ゾーンの名前 (例: `is1a`, `tk1a`)  

##### filterブロック

* `condition` - (Optional) APIリクエスト時に利用されるフィルタリング用パラメータ。詳細は[conditionブロック](#condition)を参照  
* `id` - (Optional) 対象リソースのID 
* `names` - (Optional) 対象リソースの名前。指定値と部分一致するリソースが参照対象となる。複数指定した場合はAND条件となる  

##### conditionブロック

* `name` - (Required) 対象フィールド名。大文字/小文字を区別する  
* `values` - (Required) 対象フィールドの値。複数指定した場合はAND条件となる

## Attribute Reference

* `id` - ID
* `description` - 説明
* `expression` - フィルタリングルールのリスト。詳細は[expressionブロック](#expression)を参照
* `name` - 名前

##### expressionブロック

* `allow` - ルールにマッチした通信を許可するかのフラグ
* `description` - 説明
* `destination_port` - 宛先ポート、または宛先ポート範囲。次のような値となる (`1024`, `1024-2048`)
* `protocol` - プロトコル。次のいずれかとなる［`http`/`https`/`tcp`/`udp`/`icmp`/`fragment`/`ip`]
* `source_network` - 送信元IPアドレス、または送信元CIDRブロック。次のような値となる (`192.0.2.1`, `192.0.2.0/24`)
* `source_port` - 送信元ポート、または送信元ポート範囲。次のような値となる (`1024`, `1024-2048`)


