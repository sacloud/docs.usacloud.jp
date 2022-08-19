# アップグレードガイド(v2.18)

## 目次

- [VPCルータ: スケジュールメンテナンス機能](#diff1)
- [VPCルータ: サイト間VPNパラメータ](#diff2)
- [各データソースのfilter.conditionで完全一致/部分一致のどちらで検索するか指定可能に](#diff3)
  
### VPCルータ: スケジュールメンテナンス機能 {: #diff1 }

スケジュールメンテナンス機能が利用可能になりました。

```tf
resource "sakuracloud_vpc_router" "foobar" {
  # ...中略

  # スケジュールメンテナンスの設定
  scheduled_maintenance {
    day_of_week = "tue" # 曜日
    hour        = 1     # 開始時間
  }
}
```

### VPCルータ: サイト間VPNパラメータ {: #diff2 }

サイト間VPNパラメータが指定可能になりました。

```tf
resource "sakuracloud_vpc_router" "foobar" {
  # ...中略

  # 接続先1
  site_to_site_vpn {
    # ...略
  }

  # 接続先n
  site_to_site_vpn {
    # ...略
  }

  # サイト間VPNパラメータ
  site_to_site_vpn_parameter {
    ike {
      lifetime = 28800
      dpd {
        interval = 15
        timeout  = 30
      }
    }
    esp {
      lifetime = 1800
    }
    encryption_algo = "aes256"
    hash_algo       = "sha256"
  }
}
```

### 各データソースのfilter.conditionで完全一致/部分一致のどちらで検索するか指定可能に {: #diff3 }

各データソースの`filter.condition`において、完全一致/部分一致のどちらで検索するかを`operator`で指定可能になりました。

指定可能な値:

- `partial_match_and`(デフォルト): 部分一致、複数指定した場合はAND結合
- `exact_match_or`: 完全一致、複数指定した場合はOR結合

```tf
data "sakuracloud_archive" "foobar" {
  filter {
    condition {
      name     = "Name"
      values   = ["Windows Server 2022 for RDS"]
      operator = "exact_match_or"
    }
  }
}
```