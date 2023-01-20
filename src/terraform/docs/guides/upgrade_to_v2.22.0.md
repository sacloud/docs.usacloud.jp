# アップグレードガイド(v2.22)

## 目次

- [sakuracloud_proxylb: 送信元IP](#diff1)
  
### sakuracloud_proxylb: 送信元IP {: #diff1 }

エンハンスドロードバランサのルールに送信元IPを指定可能になりました。

```hcl
resource "sakuracloud_proxylb" "foobar" {
  name           = "foobar"

  # ...

  rule {
    # ...
    
    source_ips = "192.2.0.1,192.12.0.2"
  }
}
```
