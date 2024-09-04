# 送信元ネットワークが制限されていない

## 概要
エンハンスドDBの送信元ネットワークを制限しない場合、悪意ある攻撃者が不正にデータベースに接続するリスクが高まります。

## 影響
悪意ある攻撃者がデータベースに不正アクセスする可能性

## 推奨事項
送信元ネットワークを適切に制限することを推奨します

## 例
### Bad case
```terraform
resource "sakuracloud_enhanced_db" "bad_enhanced_db" {
  name     = "bad_enhanced_db"
  password = var.password

  database_name = "bad_enhanced_db"
  database_type = "tidb"
  region        = "is1"
}
```

### Good case
```terraform
resource "sakuracloud_enhanced_db" "good_enhanced_db" {
  name     = "good_enhanced_db"
  password = var.password

  database_name = "good_enhanced_db"
  database_type = "tidb"
  region        = "is1"

  allowed_networks = [
    "192.0.2.0/24"
  ]
}
```

## Links
- [https://docs.usacloud.jp/terraform/r/enhanced_db/](https://docs.usacloud.jp/terraform/r/enhanced_db/)
- [https://manual.sakura.ad.jp/cloud/appliance/enhanced-db/index.html](https://manual.sakura.ad.jp/cloud/appliance/enhanced-db/index.html)
