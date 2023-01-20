# アップグレードガイド(v2.21)

## 目次

- [sakuracloud_auto_scale: トラフィック量トリガー](#diff1)
- [sakuracloud_vpc_router: DHグループ指定](#diff2)


### sakuracloud_auto_scale: トラフィック量トリガー {: #diff1 }

オートスケールでのトラフィック量トリガーが利用可能になりました。

```hcl
resource "sakuracloud_auto_scale" "foobar" {
  name           = "example"

  zones  = ["is1b"]
  config = yamlencode({
    resources: [{
      type: "Router",
      selector: {
        names: [sakuracloud_internet.foobar.name],
        zones: ["is1b"],
      },
    }],
  })
  api_key_id = "xxx"

  trigger_type = "router"
  router_threshold_scaling {
    router_prefix = "example"
    direction     = "in"
    mbps          = 20
  }
}
```


### sakuracloud_vpc_router: DHグループ指定 {: #diff2 }

VPCルータでDHグループの指定が可能になりました。

```hcl
resource "sakuracloud_vpc_router" "premium" {
  # ...
  
  site_to_site_vpn_parameter {
    dh_group = "modp2048"
    
    # ...
  }
}
```