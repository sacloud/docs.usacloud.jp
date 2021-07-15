# アップグレードガイド(v2.6.0)

## 目次

- [ウェブアクセラレータのサポート](#diffA)
    

### ウェブアクセラレータのサポート(#diffA)

ウェブアクセラレータ向けのリソース/データソースが追加されました。

利用例:

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
