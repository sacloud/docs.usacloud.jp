# Terraform for さくらのクラウド(v2)

---

## 概要

`Terraform for さくらのクラウド`とは、
[Terraform](https://terraform.io)から[さくらのクラウド](http://cloud.sakura.ad.jp)を操作するためのTerraform用プラグインです。  

!!! Note
    このドキュメントはterraform-provider-sakuracloud v2を対象としています。  
    v1をご利用の場合は以下のドキュメントを参照してください。  
      
    [Terraform for さくらのクラウド(v1)](https://docs.usacloud.jp/terraform-v1/)
    
!!! Note
    このドキュメントはterraform-provider-sakuracloudの英語版ドキュメントを元に翻訳/加筆したものです。  
    最新のドキュメントはterraform-provider-sakuracloudのリポジトリの`website`ディレクトリを参照してください。
      
    [https://github.com/sacloud/terraform-provider-sakuracloud/](https://github.com/sacloud/terraform-provider-sakuracloud/)

## 利用例

```tf
# Configure the SakuraCloud Provider
terraform {
  required_providers {
    sakuracloud = {
      source = "sacloud/sakuracloud"

      # We recommend pinning to the specific version of the SakuraCloud Provider you're using
      # since new versions are released frequently
      version = "2.25.0"
      #version = "~> 2"
    }
  }
}
provider "sakuracloud" {
  # More information on the authentication methods supported by
  # the SakuraCloud Provider can be found here:
  # https://docs.usacloud.jp/terraform/provider/

  # profile = "..."
}

variable password {}

data "sakuracloud_archive" "ubuntu" {
  os_type = "ubuntu2004"
}

resource "sakuracloud_disk" "example" {
  name              = "example"
  source_archive_id = data.sakuracloud_archive.ubuntu.id

  # If you want to prevent re-creation of the disk
  # when archive id is changed, please uncomment this.
  # lifecycle {
  #   ignore_changes = [
  #     source_archive_id,
  #   ]
  # }
}

resource "sakuracloud_server" "example" {
  name        = "example"
  disks       = [sakuracloud_disk.example.id]
  core        = 1
  memory      = 2
  description = "description"
  tags        = ["app=web", "stage=staging"]

  network_interface {
    upstream = "shared"
  }

  disk_edit_parameter {
    hostname        = "example"
    password        = var.password
  }
}
```

