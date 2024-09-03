# 80番ポートの待ち受けに対してHTTPSへのリダイレクトが有効化されていない

## 概要
HTTPを使用すると通信内容が暗号化されないため、悪意ある攻撃者が通信内容を不正に傍受するリスクが高まります。

## 影響
通信内容が暗号化されず、保護されない

## 推奨事項
HTTPからHTTPSへのリダイレクトを有効化することを推奨します

## 例
### Bad case
```terraform
resource "sakuracloud_proxylb" "bad_proxylb" {
  name = "bad_proxylb"
  plan = 100

  health_check {
    protocol   = "http"
    delay_loop = 10
    path       = "/"
  }

  bind_port {
    proxy_mode = "http"
    port       = 80
  }
}
```

### Good case
```terraform
resource "sakuracloud_proxylb" "good_proxylb" {
  name = "good_proxylb"
  plan = 100

  health_check {
    protocol   = "http"
    delay_loop = 10
    path       = "/"
  }

  bind_port {
    proxy_mode        = "http"
    port              = 80
    redirect_to_https = true
  }

  bind_port {
    proxy_mode = "https"
    port       = 443
  }

  syslog {
    server = "192.0.2.1"
    port   = 514
  }
}
```

## Links
- [https://docs.usacloud.jp/terraform/r/proxylb/](https://docs.usacloud.jp/terraform/r/proxylb/)
- [https://manual.sakura.ad.jp/cloud/appliance/enhanced-lb/index.html#id13](https://manual.sakura.ad.jp/cloud/appliance/enhanced-lb/index.html#id13)
