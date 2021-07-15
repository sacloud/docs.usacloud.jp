# 2要素認証SMS: sakuracloud_esme

2要素認証SMS(ESME)の情報を参照するためのデータソース

## Example Usage

```tf
data "sakuracloud_esme" "foobar" {
  filter {
    names = ["foobar"]
  }
}
```

<div class="editor">

<h2><a href="https://zouen-alpha.usacloud.jp/#data/esme" target="_blank" rel="noopener noreferrer">Code Editor</a></h2>

<iframe src="https://zouen-alpha.usacloud.jp/#data/esme"></iframe>

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
* `icon_id` - アイコンID
* `name` - 名前
* `tags` - タグ
* `send_message_with_generated_otp_api_url` - SMS送信(OTP自動生成)APIのURL
* `send_message_with_inputted_otp_api_url` - SMS送信(OTP入力)APIのURL
