# アップグレードガイド(v2.12)

## 目次

- [cloud-init対応](#diff1)
  
### cloud-init対応 {: #diff1 }

サーバの起動時にcloud-init用のUserDataを指定可能になりました。  

利用例:

```tf
resource "sakuracloud_server" "foobar" {
  name        = "example"
  disks       = [local.disk_id]
  network_interface {
    upstream = "shared"
  }
  core   = 2
  memory = 4

  user_data = join("\n", [
    "#cloud-config",
    yamlencode({
      hostname: "example",
      password: local.password,
      chpasswd: {
        expire: false,
      }
      ssh_pwauth: false,
      ssh_authorized_keys: [
        file("~/.ssh/id_rsa.pub"),
      ],
    }),
  ])
}
```