---
layout: "sakuracloud"
page_title: "SakuraCloud: sakuracloud_webaccel_activation"
subcategory: "WebAccelerator"
description: |-
  Manages a SakuraCloud WebAccelerator Site Status.
---

# sakuracloud_webaccel_activation

ウェブアクセラレーターのサイト有効化・無効化を制御するリソース。

## 利用例

```hcl
data "sakuracloud_webaccel" "site" {
  name = "your-site-name"
  # or
  # domain = "your-domain"
}

resource "sakuracloud_webaccel_activation" "site_status" {
  site_id    = data.sakuracloud_webaccel.site.id
  enabled    = true
}
```

## Argument Reference

* `site_id` - (Required) 対象のサイトID
* `enabled` - (Required) サイトを有効化するフラグ

## Attribute Reference

* `site_id` - 対象のサイトID
* `enabled` - サイトの有効化状態を表すフラグ
