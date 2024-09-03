# ディスク暗号化機能が有効化されていない

## 概要
ディスク暗号化機能を有効化されていない場合、ホストサーバやストレージ装置などにおける不正な窃取や情報流出のリスクが高まる可能性があります。

## 影響
ホストサーバ内のIOバッファや仮想ネットワーク、ストレージ装置とのネットワーク経路、およびストレージ装置内に保存されるデータの安全性が低下する可能性

## 推奨事項
ディスク暗号化機能を有効化することを推奨します

## 例
### Bad case
```terraform
resource "sakuracloud_disk" "bad_disk" {
  name                 = "bad_disk"
  size                 = 20
  plan                 = "ssd"
  connector            = "virtio"
  source_archive_id    = data.sakuracloud_archive.ubuntu2204.id
  encryption_algorithm = "none"
}
```

### Good case
```terraform
resource "sakuracloud_disk" "good_disk" {
  name                 = "good_disk"
  size                 = 20
  plan                 = "ssd"
  connector            = "virtio"
  source_archive_id    = data.sakuracloud_archive.ubuntu2204.id
  encryption_algorithm = "aes256_xts"
}
```

## Links
- [https://docs.usacloud.jp/terraform/r/disk/](https://docs.usacloud.jp/terraform/r/disk/)
- [https://manual.sakura.ad.jp/cloud/storage/disk-encryption.html](https://manual.sakura.ad.jp/cloud/storage/disk-encryption.html)
