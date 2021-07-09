# DNS: sakuracloud_dns

## Example Usage

```hcl
resource "sakuracloud_dns" "foobar" {
  zone        = "example.com"
  description = "description"
  tags        = ["tag1", "tag2"]
  record {
    name  = "www"
    type  = "A"
    value = "192.168.11.1"
  }
  record {
    name  = "www"
    type  = "A"
    value = "192.168.11.2"
  }
}
```

<div class="editor">

<h2>Code Editor</h2>

<iframe src="https://zouen-alpha.usacloud.jp/#resource/dns"></iframe>

</div>


## Argument Reference

* `zone` - (Required) 対象ゾーン(例: `example.com`) / この値を変更するとリソースの再作成が行われる
* `record` - (Optional) レコードのリスト。詳細は[recordブロック](#record)を参照

##### recordブロック

* `name` - (Required) レコード名 /  `1`-`64`文字で指定
* `type` - (Required) レコード種別 / 次のいずれかを指定［`A`/`AAAA`/`ALIAS`/`CNAME`/`NS`/`MX`/`TXT`/`SRV`/`CAA`/`PTR`]
* `value` - (Required) 値
* `ttl` - (Optional) TTL

###### MX/SRVレコード関連

* `priority` - (Optional) 優先度 / `0`-`65535`の範囲で指定

###### SRVレコード関連

* `port` - (Optional) ポート番号 / `1`-`65535`の範囲で指定
* `weight` - (Optional) ウェイト / `0`-`65535`の範囲で指定

#### Common Arguments

* `description` - (Optional) 説明 / `1`-`512`文字で指定
* `icon_id` - (Optional) アイコンID
* `tags` - (Optional) タグ

#### Timeouts

`timeouts`ブロックで[カスタムタイムアウト](https://www.terraform.io/docs/configuration/resources.html#operation-timeouts)が設定可能です。  

* `create` - 作成 (デフォルト: 5分)
* `update` - 更新 (デフォルト: 5分)
* `delete` - 削除 (デフォルト: 5分)

## Attribute Reference

* `id` - ID
* `dns_servers` - DNSサーバのIPアドレスのリスト

