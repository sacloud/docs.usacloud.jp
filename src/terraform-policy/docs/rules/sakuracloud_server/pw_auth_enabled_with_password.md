# SSHにおけるパスワードでのログインが許可されている

## 概要
サーバにパスワードが設定され、SSHでのパスワードログインが許可されている場合、悪意ある攻撃者が不正にサーバにログインするリスクが高まります。

## 影響
悪意ある攻撃者による不正なサーバへのログインが成立する可能性

## 推奨事項
SSHでのパスワードログインを無効化し、公開鍵認証を有効化することを推奨します

## 例
### Bad case
```terraform
resource "sakuracloud_server" "bad_server" {
  name   = "bad_server"
  disks  = [sakuracloud_disk.disk.id]
  core   = 1
  memory = 1

  disk_edit_parameter {
    hostname        = "bad_server"
    disable_pw_auth = false

    password = var.password
  }
}
```

### Good case
```terraform
resource "sakuracloud_server" "good_server" {
  name   = "good_server"
  disks  = [sakuracloud_disk.disk.id]
  core   = 1
  memory = 1

  disk_edit_parameter {
    hostname        = "good_server"
    disable_pw_auth = true

    ssh_key_ids = [resource.sakuracloud_ssh_key.user_key.id]
  }
}
```

## Links
- [https://docs.usacloud.jp/terraform/r/server/](https://docs.usacloud.jp/terraform/r/server/)
- [https://manual.sakura.ad.jp/cloud/support/security/server.html#rootssh](https://manual.sakura.ad.jp/cloud/support/security/server.html#rootssh)
