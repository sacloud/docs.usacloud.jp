# ログ記録が有効化されていない

## 概要
ログ記録が有効化されていない場合、エンハンスドロードバランサ内部のソフトウェアで問題が発生した際、その原因や発生日時の特定が困難になる可能性があります。

## 影響
エンハンスドロードバランサの可観測性が低下する

## 推奨事項
ログ記録を有効化することを推奨します

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
- [https://manual.sakura.ad.jp/cloud/appliance/enhanced-lb/index.html#syslog](https://manual.sakura.ad.jp/cloud/appliance/enhanced-lb/index.html#syslog)
