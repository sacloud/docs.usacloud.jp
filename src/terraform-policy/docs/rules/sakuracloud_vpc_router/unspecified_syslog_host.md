# ログ記録が有効化されていない

## 概要
ログ記録が有効化されていない場合、VPCルータ内部のソフトウェアで問題が発生した際、その原因や発生日時の特定が困難になる可能性があります。

## 影響
VPCルータの可観測性が低下する

## 推奨事項
ログ記録を有効化することを推奨します

## 例
### Bad case
```terraform
resource "sakuracloud_vpc_router" "bad_vpc" {
  name                = "bad_vpc"
  internet_connection = true
}
```

### Good case
```terraform
resource "sakuracloud_vpc_router" "good_vpc" {
  name                = "good_vpc"
  syslog_host         = "192.0.2.1"
  internet_connection = true
  firewall {
    interface_index = 0
    direction       = "receive"

    expression {
      protocol            = "tcp"
      source_network      = ""
      source_port         = "443"
      destination_network = ""
      destination_port    = ""
      allow               = true
      logging             = true
      description         = "desc"
    }

    expression {
      protocol            = "ip"
      source_network      = ""
      source_port         = ""
      destination_network = ""
      destination_port    = ""
      allow               = false
      logging             = true
      description         = "desc"
    }
  }
}
```

## Links
- [https://docs.usacloud.jp/terraform/r/vpc_router/](https://docs.usacloud.jp/terraform/r/vpc_router/)
- [https://manual.sakura.ad.jp/cloud/network/vpc-router/vpc-functions.html#syslog](https://manual.sakura.ad.jp/cloud/network/vpc-router/vpc-functions.html#syslog)
