# DNS(レコード): sakuracloud_dns_record

## Example Usage

```hcl
resource "sakuracloud_dns" "foobar" {
  zone = "example.com"
}

resource "sakuracloud_dns_record" "record1" {
  dns_id = sakuracloud_dns.foobar.id
  name   = "www"
  type   = "A"
  value  = "192.168.0.1"
}

resource "sakuracloud_dns_record" "record2" {
  dns_id = sakuracloud_dns.foobar.id
  name   = "www"
  type   = "A"
  value  = "192.168.0.2"
}
```

<div class="editor">

<h2>Code Editor</h2>

<iframe src="https://zouen-alpha.usacloud.jp/#resource/dns_record"></iframe>

</div>


## Argument Reference

* `dns_id` - (Required) レコードを登録する対象ゾーン(DNSリソース)のID / この値を変更するとリソースの再作成が行われる
* `name` - (Required) レコード名 / この値を変更するとリソースの再作成が行われる
* `type` - (Required) レコード種別 / 次のいずれかを指定［`A`/`AAAA`/`ALIAS`/`CNAME`/`NS`/`MX`/`TXT`/`SRV`/`CAA`/`PTR`]/ この値を変更するとリソースの再作成が行われる
* `value` - (Required) レコードの値 / この値を変更するとリソースの再作成が行われる
* `ttl` - (Optional) TTL / この値を変更するとリソースの再作成が行われる / デフォルト:`3600`

###### MX/SRVレコード関連

* `priority` - (Optional) 優先度 / `0`-`65535`の範囲で指定 / この値を変更するとリソースの再作成が行われる

###### SRVレコード関連

* `port` - (Optional) ポート番号 / `1`-`65535`の範囲で指定 / この値を変更するとリソースの再作成が行われる
* `weight` - (Optional) ウェイト / `0`-`65535`の範囲で指定 / この値を変更するとリソースの再作成が行われる

#### Timeouts

`timeouts`ブロックで[カスタムタイムアウト](https://www.terraform.io/docs/configuration/resources.html#operation-timeouts)が設定可能です。  

* `create` - 作成 (デフォルト: 5分)
* `delete` - 削除 (デフォルト: 5分)

## Attribute Reference

* `id` - ID

