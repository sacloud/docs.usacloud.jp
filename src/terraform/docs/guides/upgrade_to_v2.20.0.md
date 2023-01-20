# アップグレードガイド(v2.20)

## 目次

- [sakuracloud_database: バージョン指定機能](#diff1)
  
### sakuracloud_database: バージョン指定機能 {: #diff1 }

データベースアプライアンス作成時にRDBMSのバージョンを指定可能となりました。  
省略した場合は現在利用可能な最新版となります。

```hcl
resource "sakuracloud_database" "example" {
  database_type    = "mariadb"
  database_version = "13" // optional
 
  # ...以下略
```
