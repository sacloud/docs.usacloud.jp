# オートスケール: sakuracloud_auto_scale

オートスケールの情報を参照するためのデータソース

## Example Usage

```tf
data "sakuracloud_auto_scale" "foobar" {
  filter {
    names = ["foobar"]
  }
}
```

<div class="editor">

<h2><a href="https://zouen-alpha.usacloud.jp/#data/auto_scale" target="_blank" rel="noopener noreferrer">Code Editor</a></h2>

<iframe src="https://zouen-alpha.usacloud.jp/#data/auto_scale"></iframe>

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
* `api_key_id` - APIキーのID
* `config` - sacloud/autoscalerの設定ファイル
* `trigger_type` - トリガータイプ、次のいずれかを指定
* `cpu_threshold_scaling` - CPU-TIMEによるスケール動作の閾値。詳細は[cpu_threshold_scalingブロック](#cpu_threshold_scaling)を参照
* `router_threshold_scaling` - トラフィック量によるスケール動作の閾値。詳細は[router_threshold_scalingブロック](#router_threshold_scaling)を参照
* `description` - 説明
* `icon_id` - アイコンID
* `name` - 名称
* `tags` - タグ
* `zones` - 監視対象が存在するゾーン名のリスト


#### `cpu_threshold_scaling` ブロック

* `down` - 性能ダウンするCPU使用率
* `server_prefix` - 監視対象のサーバ名のプリフィックス
* `up` - 性能アップするCPU使用率

#### `router_threshold_scaling`ブロック

* `router_prefix` - (Required) 監視対象のルータ名のプリフィックス
* `direction` - (Required) 監視するトラフィックの向き、次のいずれかを指定［`in`/`out`］
* `mbps` - (Required) スケール動作する閾値、Mbps単位