# VIPで80番ポートが設定されている

## 概要
HTTPを使用すると通信内容が暗号化されないため、悪意ある攻撃者が通信内容を不正に傍受するリスクが高まります。

## 影響
通信内容が暗号化されず、保護されない

## 推奨事項
HTTPSを使用して通信内容を暗号化し、保護することを推奨します

## 例
### Bad case
```terraform
resource "sakuracloud_load_balancer" "bad_lb" {
  name = "bad_lb"
  plan = "standard"
  network_interface {
    switch_id    = sakuracloud_switch.switch.id
    vrid         = 1
    ip_addresses = ["192.0.2.101"]
    netmask      = 24
    gateway      = "192.0.2.1"
  }
  vip {
    vip  = "192.0.2.201"
    port = 80

    server {
      ip_address = "192.0.2.51"
      protocol   = "http"
      path       = "/health"
      status     = 200
    }

    server {
      ip_address = "192.0.2.52"
      protocol   = "http"
      path       = "/health"
      status     = 200
    }
  }
}
```

### Good case
```terraform
resource "sakuracloud_load_balancer" "good_lb" {
  name = "good_lb"
  plan = "standard"
  network_interface {
    switch_id    = sakuracloud_switch.switch.id
    vrid         = 1
    ip_addresses = ["192.0.2.101"]
    netmask      = 24
    gateway      = "192.0.2.1"
  }
  vip {
    vip  = "192.0.2.201"
    port = 443

    server {
      ip_address = "192.0.2.51"
      protocol   = "https"
      path       = "/health"
      status     = 200
    }

    server {
      ip_address = "192.0.2.52"
      protocol   = "https"
      path       = "/health"
      status     = 200
    }
  }
}
```

## Links
- [https://docs.usacloud.jp/terraform/r/load_balancer/](https://docs.usacloud.jp/terraform/r/load_balancer/)
