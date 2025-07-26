# ウェブアクセラレータ証明書: sakuracloud_webaccel_certificate

## Example Usage

```tf
data sakuracloud_webaccel "site" {
  name = "your-site-name"
  # or
  # domain = "your-domain"
}

resource sakuracloud_webaccel_certificate "foobar" {
  site_id           = data.sakuracloud_webaccel.site.id
  certificate_chain = file("path/to/your/certificate/chain")
  private_key       = file("path/to/your/private/key")
}
```

<div class="editor">

<h2><a href="https://zouen-alpha.usacloud.jp/#resource/webaccel_certificate" target="_blank" rel="noopener noreferrer">Code Editor</a></h2>

<iframe src="https://zouen-alpha.usacloud.jp/#resource/webaccel_certificate"></iframe>

</div>

## Argument Reference

* `site_id` - (Required) サイトのID
* `private_key` - (Optional) 秘密鍵。`certificate_chain`と共に使用する。`lets_encrypt`と同時には指定できない。
* `certificate_chain` - (Optional) サイトの証明書チェーン。`private_key`と共に使用する。`lets_encrypt`と同時には指定できない。
* `lets_encrypt` - (Optional) Let's Encrypt証明書の自動更新を有効化するフラグ。`true`以外の値をサポートしない。`private_key`または`certificate_chain`とは同時に指定できない。

## Attribute Reference

* `id` - ID
* `dns_names`
* `issuer_common_name`
* `not_after`
* `not_before`
* `serial_number`
* `sha256_fingerprint`
* `subject_common_name`

