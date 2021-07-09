# アップグレードガイド(v2.9)

## 目次

- [ロードバランサのVIP上限数が20へ](#diff1)
- [VPCルータでのWireGuardサーバ機能](#diff2)
- [エンハンスドロードバランサでのルールベールバランシング機能の拡張](#diff3)

### ロードバランサのVIP上限数が20へ(#diff1)

ロードバランサでのVIP上限数が20に拡張されました。

### VPCルータでのWireGuardサーバ機能(#diff2)

VPCルータでWireGuardサーバ機能が利用可能になりました。

利用例:

```hcl
resource sakuracloud_vpc_router "example" {
  # ...

  wire_guard {
    ip_address = "192.168.31.1/24"
    peer {
      name       = "example"
      ip_address = "192.168.31.11"
      public_key = "<your-public-key>"
    }
  }
}
```

### エンハンスドロードバランサでのルールベールバランシング機能の拡張(#diff3)

エンハンスドロードバランサでのルールベールバランシングでリダイレクト/固定応答に対応しました。

利用例:

```hcl
  # リダイレクト
  rule {
    action               = "redirect"
    host                 = "www2.example.com"
    path                 = "/"
    group                = "group1"
    redirect_location    = "https://redirect.example.com"
    redirect_status_code = "301"
  }

  # 固定応答
  rule {
    action               = "fixed"
    host                 = "www3.example.com"
    path                 = "/"
    group                = "group1"
    fixed_status_code    = "200"
    fixed_content_type   = "text/plain"
    fixed_message_body   = "body"
  }
```