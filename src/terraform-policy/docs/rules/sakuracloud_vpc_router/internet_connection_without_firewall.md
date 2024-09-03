# インターネット接続が有効化されているが、ファイアウォールが設定されていない

## 概要
インターネット接続が有効化されている場合、ファイアウォールが適切に設定されていないと、悪意ある攻撃者が不正にサーバにアクセスするリスクが高まります。

## 影響
VPCルータに接続されているサーバなどに対して、悪意ある攻撃者が不正な通信を行う可能性

## 推奨事項
グローバルインターフェースに対してファイアウォールを適切に設定することを推奨します

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
- [https://manual.sakura.ad.jp/cloud/network/vpc-router/vpc-firewall.html](https://manual.sakura.ad.jp/cloud/network/vpc-router/vpc-firewall.html)
