# GitHubからのSSH用の公開鍵を取得

さくらのクラウドのコントロールパネルには、GitHub上のユーザー名を指定してSSH用の公開鍵を取得しサーバ作成時に利用する機能があります。  
この機能をTerraformで実現するためにhttpプロバイダーが利用可能です。

```terraform
# GitHub上の公開鍵を参照するためのデータソース
data "http" "key" {
  url = "https://github.com/<GitHubのユーザ名>.keys" # 任意のユーザー名に置き換える
}
```

GitHubから公開鍵を取得してサーバ作成に利用するコード例は以下の通りです。

```terraform
terraform {
  required_providers {
    http = {
      source  = "hashicorp/http"
      version = "~> 3"
    }
    sakuracloud = {
      source  = "sacloud/sakuracloud"
      version = "~> 2"
    }
  }
}

data "sakuracloud_archive" "ubuntu" {
  os_type = "ubuntu2204"
}

resource "sakuracloud_disk" "example" {
  name              = "example"
  source_archive_id = data.sakuracloud_archive.ubuntu.id
}

resource "sakuracloud_server" "example" {
  name  = "example"
  disks = [sakuracloud_disk.example.id]

  network_interface {
    upstream = "shared"
  }

  disk_edit_parameter {
    disable_pw_auth = true
    ssh_keys        = split("\n", trimspace(data.http.key.response_body)) // Note: 複数の公開鍵が登録されている場合は改行で結合されている
  }
}

data "http" "key" {
  url = "https://github.com/<GitHubのユーザ名>.keys" # 任意のユーザー名に置き換える
}
```