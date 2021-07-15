# IPv4逆引きアドレス: sakuracloud_ipv4_ptr

## Example Usage

```tf
resource sakuracloud_server "server" {
  name = "foobar"
  network_interface {
    upstream = "shared"
  }
}

resource "sakuracloud_ipv4_ptr" "foobar" {
  ip_address     = sakuracloud_server.server.ip_address
  hostname       = "www.example.com"
  retry_max      = 30
  retry_interval = 10
}
```

## Argument Reference

* `hostname` - (Required) PTRレコードの値 / FQDNを指定
* `ip_address` - (Required) 対象IPアドレス

#### リトライ関連

!!! Note
    PTRレコードを登録するには正引きできる状態になっている必要があります。  
    正引きレコードを登録したばかりの場合、PTRレコード登録に失敗することがあります。
    レコード登録に失敗した場合、指定した間隔で指定回数までリトライが行われます。
    必要に応じて十分に大きな値を指定してください。

* `retry_interval` - (Optional) リトライ間隔秒数 / デフォルト:`10`
* `retry_max` - (Optional) リトライ回数 / デフォルト:`30`

#### Common Arguments

* `zone` - (Optional) リソースを作成する対象ゾーンの名前(例: `is1a`, `tk1a`) / この値を変更するとリソースの再作成が行われる

#### Timeouts

`timeouts`ブロックで[カスタムタイムアウト](https://www.terraform.io/docs/configuration/resources.html#operation-timeouts)が設定可能です。  

* `create` - 作成 (デフォルト: 60分)
* `update` - 更新 (デフォルト: 60分)
* `delete` - 削除 (デフォルト: 5分)

## Attribute Reference

* `id` - ID

