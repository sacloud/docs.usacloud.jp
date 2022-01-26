# アップグレードガイド(v2.16)

## 目次

- [CentOS8パブリックアーカイブの除去](#diff1)
- [VPCルータでのDNSフォワーディング](#diff2)
- [シンプル監視でのリトライ関連項目](#diff3)
- [`os_type`の更新](#diff4)(v2.16.1以降)
  
### CentOS8パブリックアーカイブの除去 {: #diff1 }

CentOS8のサポート終了に伴い`sakuracloud_archive`の`os_type`からも`centos8`が除去されました。
代わりに後続/互換OSなどをご利用ください。

### VPCルータでのDNSフォワーディング {: #diff2 }

VPCルータでDNSフォワーディング関連項目が指定可能になりました。

```tf
resource "sakuracloud_vpc_router" "premium" {
  name        = "premium"
  
  # ...
  
  dns_forwarding {
    interface_index = 1
    dns_servers = ["133.242.0.3", "133.242.0.4"]
  }
```

### シンプル監視でのリトライ関連項目 {: #diff3 }

シンプル監視でリトライ関連項目が指定可能になりました。

```tf
resource "sakuracloud_simple_monitor" "foobar" {
  target = "www.example.com"

  max_check_attempts = 3
  retry_interval     = 10
  
  # ...
}
```

### `os_type`の更新(v2.16.1以降) {: #diff4 }

`data.sakuracloud_archive`の`os_type`から以下の値が除去されました。  

- `coreos`
- `freebsd`
