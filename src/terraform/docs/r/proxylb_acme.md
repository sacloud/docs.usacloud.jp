# エンハンスドロードバランサ(ACME設定): sakuracloud_proxylb_acme

## Example Usage

```hcl
resource sakuracloud_proxylb_acme "foobar" {
  proxylb_id        = sakuracloud_proxylb.foobar.id
  accept_tos        = true
  common_name       = "www.example.com"
  subject_alt_names = ["www1.example.com"]
  update_delay_sec  = 120
}

data "sakuracloud_proxylb" "foobar" {
  filter {
    names = ["foobar"]
  }
}
```

!!! Note
    このリソースを利用する場合、エンハンスドロードバランサリソース(`sakuracloud_proxylb`)の`certificate`ブロックの値は上書きされます。  
    両者の同時指定はできません。

<div class="editor">

<h2>Code Editor</h2>

<iframe src="https://zouen-alpha.usacloud.jp/#resource/proxylb_acme"></iframe>

</div>

## Argument Reference

* `accept_tos` - (Required) [Let's Encrypt terms of service](https://letsencrypt.org/repository/)への同意フラグ  
この項目は明示的に`true`に設定する必要があります / この値を変更するとリソースの再作成が行われる
* `common_name` - (Required) 証明書発行対象のFQDN / 名前解決できる値を指定する必要があります / この値を変更するとリソースの再作成が行われる
* `proxylb_id` - (Required) ACMEを設定する対象のエンハンスドロードバランサID / この値を変更するとリソースの再作成が行われる
* `subject_alt_names` - (Optional) 証明書発行対象のSANs / この値を変更するとリソースの再作成が行われる
* `update_delay_sec` - (Optional) ACMEを有効にするまでの待ち時間 / この値を変更するとリソースの再作成が行われる

!!! Note
    エンハンスドロードバランサでLet's Encryptによる証明書発行には[Let's Encrypt terms of service](https://letsencrypt.org/repository/)に同意する必要があります。  
    Let's Encrypt terms of service: https://letsencrypt.org/repository/
    このため、このリソースを使用する際は`accept_tos`に`true`を明示的に設定する必要があります

!!! Note
    エンハンスドロードバランサでACME設定を有効にするには、`common_name`で指定したFQDNを名前解決できる必要があります。  
    DNSレコードを登録した直後だと名前解決できない場合があります。  
    このため、必要に応じて`update_delay_sec`を適切に設定してください。

#### Timeouts

`timeouts`ブロックで[カスタムタイムアウト](https://www.terraform.io/docs/configuration/resources.html#operation-timeouts)が設定可能です。  

* `create` - 作成 (デフォルト: 20分)
* `delete` - 削除 (デフォルト: 5分)

## Attribute Reference

* `id` - ID
* `certificate` - 証明書設定のリスト。詳細は[certificateブロック](#certificate)を参照

##### certificateブロック

* `additional_certificate` - 追加証明書のリスト。詳細は[additional_certificateブロック](#additional_certificate)を参照
* `intermediate_cert` - 中間証明書
* `private_key` - 秘密鍵
* `server_cert` - サーバ証明書

##### additional_certificateブロック

* `intermediate_cert` - 中間証明書
* `private_key` - 秘密鍵
* `server_cert` - サーバ証明書

