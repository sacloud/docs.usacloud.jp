# アップグレードガイド(v2.24)

## 目次

- [sakuracloud_enhanced_db: タイプ/リージョン/接続元ネットワーク指定](#diff1)
  
### sakuracloud_enhanced_db: タイプ/リージョン/接続元ネットワーク指定 {: #diff1 }

指定可能な項目が追加されました。

```hcl
resource "sakuracloud_enhanced_db" "foobar" {
  name           = "example"
  database_name  = "example"
  password       = "password"
  
  # 以下3つが追加
  database_type  = "tidb" # or mariadb
  region         = "is1"
  allowed_networks = ["192.0.2.1/32"]
}
```