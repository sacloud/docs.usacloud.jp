# マネージドPKI: sakuracloud_certificate_authority

マネージドPKIの情報を参照するためのデータソース

## Example Usage

```tf
data "sakuracloud_certificate_authority" "foobar" {
  filter {
    names = ["foobar"]
  }
}
```

<div class="editor">

<h2><a href="https://zouen-alpha.usacloud.jp/#data/certificate_authority" target="_blank" rel="noopener noreferrer">Code Editor</a></h2>

<iframe src="https://zouen-alpha.usacloud.jp/#data/certificate_authority"></iframe>

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
* `certificate` - CA証明書データ(PEM format)
* `client` - クライアント証明書。詳細は[clientブロック](#client)を参照
* `crl_url` - CRLのURL
* `description` - 説明
* `icon_id` - アイコンID
* `name` - 名前
* `not_after` - CA証明書の有効期間終了(RFC3339 format)
* `not_before` - CA証明書の有効期間開始(RFC3339 format)
* `serial_number` - CAのシリアルナンバー
* `server` - サーバー証明書、詳細は[serverブロック](#server)を参照
* `subject_string` - CA証明書のサブジェクトの文字列表現
* `tags` - タグ


---

#### clientブロック

* `certificate` - 証明書データ(PEM format)
* `hold` - 一時停止フラグ
* `id` - ID
* `issue_state` - 発行状態
* `not_after` - 証明書の有効期間終了(RFC3339 format)
* `not_before` - 証明書の有効期間開始(RFC3339 format)
* `serial_number` - シリアルナンバー
* `subject_string` - 証明書のサブジェクトの文字列表現
* `url` - 証明書の発行用URL、発行方法がURLの場合のみ有効

---

#### serverブロック

* `certificate` - 証明書データ(PEM format)
* `id` - ID
* `issue_state` - 発行状態
* `not_after` - 証明書の有効期間終了(RFC3339 format)
* `not_before` - 証明書の有効期間開始(RFC3339 format)
* `serial_number` - シリアルナンバー
* `subject_alternative_names` - SANs
* `subject_string` - 証明書のサブジェクトの文字列表現


