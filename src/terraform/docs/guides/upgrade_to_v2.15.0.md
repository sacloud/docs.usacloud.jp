# アップグレードガイド(v2.15)

## 目次

- [シンプル監視でのSNI検証](#diff1)
  
### シンプル監視でのSNI検証 {: #diff1 }

シンプル監視でのSSL証明書の有効期限監視(`sslcertificate`)にて、
取得したSSL証明書のホストネーム情報にリクエストしたホスト名(FQDN)が含まれるかを検証するためのオプション`verify_sni`が追加されました。


利用例:

```tf
resource "sakuracloud_simple_monitor" "foobar" {
   target = "www.example.com"

   delay_loop = 60
   health_check {
      protocol       = "sslcertificate"
      port           = 443
      verify_sni     = true
      remaining_days = 30
   }

   # ...
}
```