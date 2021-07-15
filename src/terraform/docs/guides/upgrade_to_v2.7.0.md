# アップグレードガイド(v2.7.0)

## 目次

- [VPCルータのバージョン指定](#diffA)
- [データベースアプライアンスでのパラメータ指定](#diffB)
    

### VPCルータのバージョン指定 {: #diffA }

VPCルータでバージョン指定が可能になりました。

利用例:

```tf
resource "sakuracloud_vpc_router" "standard" {
  name      = "standard"
  
  version = 2
}
```

### データベースアプライアンスでのパラメータ指定 {: #diffB }

データベースアプライアンスでRDBMS固有のパラメータを指定可能になりました。  

利用例:

```tf
resource "sakuracloud_database" "foobar" {
  # 中略...
  
  parameters = {
    max_connections = 100
  }
}
```