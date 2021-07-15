# アップグレードガイド(v2.4.0)

## 目次

- [Terraform Registry経由でのプロバイダーのインストール](#diffTFR)
- [東京第2ゾーン](#diffTk1b)
    

### Terraform Registry経由でのプロバイダーのインストール {: #diffTFR }

Terraform Registry経由でのプロバイダーのインストールが可能となりました。
tfファイルに以下のように記述することでプロバイダーのインストールが行えます。  

```
# Configure the SakuraCloud Provider
terraform {
  required_providers {
    sakuracloud = {
      source = "sacloud/sakuracloud"
      version = "2.4.0"
    }
  }
}
provider "sakuracloud" {
  # ...
}
```

### 東京第2ゾーン {: #diffTk1b }

東京第2ゾーンがデフォルトで利用可能となりました。
v2.4以前をご利用の場合はtfファイルに以下のように記述することで利用可能です。

```
provider "sakuracloud" {
  zones = ["tk1a", "tk1b", "is1a", "is1b", "tk1v"]
}
```