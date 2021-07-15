# アップグレードガイド(v2.10)

## 目次

- [エンハンスドデータベースのサポート](#diff1)
- [シンプル監視でのタイムアウト設定](#diff2)
- [エンハンスドロードバランサでのSyslogサーバ設定](#diff3)
- [エンハンスドロードバランサでのSSLポリシー設定](#diff4)
  
### エンハンスドデータベースのサポート(#diff1)

Labプロダクトのエンハンスドデータベース(TiDB)がサポートされました。

利用例:

```tf
resource "sakuracloud_enhanced_db" "foobar" {
  name            = "example"

  database_name   = "your_db_name"
  password        = "your-password"

  description = "description"
  tags        = ["tag1", "tag2"]
}
```

Note: Labプロダクトについては[https://manual.sakura.ad.jp/cloud/lab/about.html](https://manual.sakura.ad.jp/cloud/lab/about.html)を参照の上でご利用ください。  

### シンプル監視でのタイムアウト設定(#diff2)

シンプル監視でタイムアウト設定が行えるようになりました。

### エンハンスドロードバランサでのSyslogサーバ設定(#diff3)

エンハンスドロードバランサでログ出力先となるSyslogサーバの設定を行えるようになりました。  

利用例:

```tf
resource "sakuracloud_proxylb" "foobar" {
  # 中略

  syslog {
    server = "192.0.2.1"
    port = 514
  }
}
```

### エンハンスドロードバランサでのSSLポリシー設定(#diff4)

エンハンスドロードバランサでSSLポリシーの設定が行えるようになりました。

