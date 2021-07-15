# アップグレードガイド(v2.5.0)

## 目次

- [2要素認証SMS(ESME)の追加](#diffA)
- [アーカイブデータソースでのUbuntu 20.04対応](#diffB)
    

### 2要素認証SMS(ESME)の追加 {: #diffA }

2要素認証SMS(ESME)リソース/データソースが追加されました。

リソース利用例:

```tf
resource "sakuracloud_esme" "foobar" {
  name        = "foobar"
  description = "description"
  tags        = ["tag1", "tag2"]
}
```

データソース利用例:

```tf
data "sakuracloud_esme" "foobar" {
  filter {
    names = ["foobar"]
  }
}
```

### アーカイブデータソースでのUbuntu 20.04対応 {: #diffB }

アーカイブデータソース(`sakuracloud_archive`)の`os_type`パラメータでUbuntu 20.04を指定可能になりました。

```tf
data "sakuracloud_archive" "foobar" {
  os_type = "ubuntu2004"
}
```