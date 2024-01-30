# アップグレードガイド(v2.25)

## 目次

- [sakuracloud_proxylb: リクエストヘッダによる振り分けルール](#diff1)
- [sakuracloud_server: AMDプラン](#diff2)
  
### sakuracloud_proxylb: リクエストヘッダによる振り分けルール {: #diff1 }

ルールの指定時にリクエストヘッダ関連のパラメータを指定可能になりました。

```hcl
resource "sakuracloud_proxylb" "foobar" {
  # ...中略...
  
  rule {
    action             = "fixed"
    group              = "group1"
    
    request_header_name  = "foo"
    request_header_value = "1"
    
    request_header_value_ignore_case = "true"
    request_header_value_not_match   = "true"
    
    # ...
  }
}
```

### sakuracloud_server: AMDプラン {: #diff2 }

AMDプランに対応しました。

```hcl
resource "sakuracloud_server" "foobar" {
  name       = "example"
  core       = 32
  memory     = 120
  cpu_model  = "amd_epyc_7713p"
  commitment = "dedicatedcpu"

  # ...
}
```