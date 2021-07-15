# ゾーン情報: sakuracloud_zone

ゾーン情報を参照するためのデータソース

## Example Usage

```tf
# カレントゾーンの情報を参照
data "sakuracloud_zone" "current" {}

# 指定のゾーンの情報を参照
data "sakuracloud_zone" "is1a" {
  name = "is1a"
}
```

<div class="editor">

<h2><a href="https://zouen-alpha.usacloud.jp/#data/zone" target="_blank" rel="noopener noreferrer">Code Editor</a></h2>

<iframe src="https://zouen-alpha.usacloud.jp/#data/zone"></iframe>

</div>


## Argument Reference

* `name` - (Optional) 対象ゾーンの名前 (例: `is1a`, `tk1a`)  

## Attribute Reference

* `id` - ID
* `description` - 説明
* `dns_servers` - DNSサーバのID
* `region_id` - ゾーンが属するリージョンのID
* `region_name` - ゾーンが属するリージョンの名前
* `zone_id` - ゾーンのID(さくらのクラウド上でのリソースID)



