# コンテナレジストリ: sakuracloud_container_registry

## Example Usage

```hcl
variable users {
  type = list(object({
    name       = string
    password   = string
    permission = string
  }))
  default = [
    {
      name       = "user1"
      password   = "password1"
      permission = "all"
    },
    {
      name       = "user2"
      password   = "password2"
      permission = "readwrite"
    }
  ]
}

resource "sakuracloud_container_registry" "foobar" {
  name            = "foobar"
  virtual_domain  = "your-domain.example.com"
  subdomain_label = "your-subdomain-label"
  access_level    = "readwrite" # this must be one of ["readwrite"/"readonly"/"none"]

  description = "description"
  tags        = ["tag1", "tag2"]

  dynamic user {
    for_each = var.users
    content {
      name       = user.value.name
      password   = user.value.password
      permission = user.value.permission
    }
  }
}
```

<div class="editor">

<h2>Code Editor</h2>

<iframe src="https://zouen-alpha.usacloud.jp/#resource/container_registry"></iframe>

</div>


## Argument Reference

* `name` - (Required) 名前 / `1`-`64`文字で指定
* `access_level` - (Required) アクセスレベル / この値は次のいずれかを指定［`readwrite`/`readonly`/`none`]
* `subdomain_label` - (Required) サブドメインラベル /  `1`-`64`文字で指定 / この値を変更するとリソースの再作成が行われる
* `user` - (Optional) ユーザー設定のリスト。詳細は[userブロック](#user)を参照
* `virtual_domain` - (Optional) 独自ドメイン(FQDN)


##### userブロック

* `name` - (Required) ユーザー名
* `password` - (Required) パスワード
* `permission` - (Required) ユーザーの権限 / 次のいずれかを指定［`all`/`readwrite`/`readonly`]

#### Common Arguments

* `description` - (Optional) 説明 / `1`-`512`文字で指定
* `icon_id` - (Optional) アイコンID
* `tags` - (Optional) タグ

#### Timeouts

`timeouts`ブロックで[カスタムタイムアウト](https://www.terraform.io/docs/configuration/resources.html#operation-timeouts)が設定可能です。  

* `create` - 作成 (デフォルト: 5分)
* `update` - 更新 (デフォルト: 5分)
* `delete` - 削除 (デフォルト: 5分)

## Attribute Reference

* `id` - ID
* `fqdn` - コンテナレジストリにアクセスするためのFQDN / この値は`subdomain_label` + `.sakuracr.jp`となる



