# アップグレードガイド(v2.16)

## 目次

- [オートスケール](#diff1)
- [`os_type`の更新(Ubuntu 22.04の追加、Windows系OSの除去)](#diff2)
- [VPCルータでのネットマスク/29のサポート](#diff3)
  
### オートスケール {: #diff1 }

オートスケールが利用可能になりました。

```tf
resource "sakuracloud_auto_scale" "foobar" {
  name  = "example"
  zones = [local.zone]

  config = jsonencode({
    resources : [{
      type : "Server",
      selector : {
        names : [sakuracloud_server.foobar.name],
        zones : [local.zone],
      },
    }],
  })

  api_key_id = local.api_key_id

  cpu_threshold_scaling {
    server_prefix = local.server_name_prefix
    up            = 80
    down          = 20
  }
}
```

### `os_type`の更新(Ubuntu 22.04の追加、Windows系OSの除去) {: #diff2 }

`data.sakuracloud_archive`の`os_type`に以下の値が追加されました。

- `ubuntu2204`

また、Windows系OS向けの以下の値が除去されました。

- `windows2016`
- `windows2016-rds`
- `windows2016-rds-office`
- `windows2016-sql-web`
- `windows2016-sql-standard`
- `windows2016-sql-standard-all`
- `windows2016-sql2017-standard`
- `windows2016-sql2017-enterprise`
- `windows2016-sql2017-standard-all`
- `windows2019`
- `windows2019-rds`
- `windows2019-rds-office2019`
- `windows2019-sql2017-web`
- `windows2019-sql2019-web`
- `windows2019-sql2017-standard`
- `windows2019-sql2019-standard`
- `windows2019-sql2017-enterprise`
- `windows2019-sql2019-enterprise`
- `windows2019-sql2017-standard-all`
- `windows2019-sql2019-standard-all`

今後Windows系OSを利用したい場合、`os_type`の代わりにnamesやtagsなどを指定してください。

```tf
data "sakuracloud_archive" "foobar" {
  filter {
    names = ["Windows Server 2022 for RDS"]
    #tags  = ["with-office"]
  }
}
```

### VPCルータでのネットマスク/29のサポート {: #diff3 }

`sakuracloud_vpc_router`の`private_network_interface.netmask`にて/29が指定可能になりました。