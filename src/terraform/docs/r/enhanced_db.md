# sakuracloud_enhanced_db

Manages a SakuraCloud sakuracloud_enhanced_db.

## Example Usage

```tf
resource "sakuracloud_enhanced_db" "foobar" {
  name            = "example"
  password        = "your-password"
  
  database_name   = "example"
  database_type   = "tidb"
  region          = "is1"

  description = "..."
  tags        = ["...", "..."]
}
```

<div class="editor">

<h2><a href="https://zouen-alpha.usacloud.jp/#resource/enhanced_db" target="_blank" rel="noopener noreferrer">Code Editor</a></h2>

<iframe src="https://zouen-alpha.usacloud.jp/#resource/enhanced_db"></iframe>

</div>

## Argument Reference

* `name` - (Required) リソース名
* `database_name` - (Required) データベース名
* `password` - (Required) パスワード
* `database_type` - (Required) データベースタイプ / この値は次のいずれかを指定［`tidb`/`mariadb`］/ この値を変更するとリソースの再作成が行われる
* `region` - (Required) データベースを配置するリージョン / この値は次のいずれかを指定［`is1`/`tk1`］/ この値を変更するとリソースの再作成が行われる
* `allowed_networks` - (Optional) A list of CIDR blocks allowed to connect.
* `icon_id` - (Optional) The icon id to attach to the Enhanced Database.
* `description` - (Optional) The description of the Enhanced Database. The length of this value must be in the range[`1`-`512`].
* `tags` - (Optional) Any tags to assign to the Enhanced Database.



### Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/docs/configuration/resources.html#operation-timeouts) for certain actions:

* `create` - (Defaults to 5 minutes) Used when creating the sakuracloud_enhanced_db
* `update` - (Defaults to 5 minutes) Used when updating the sakuracloud_enhanced_db
* `delete` - (Defaults to 5 minutes) Used when deleting sakuracloud_enhanced_db


## Attribute Reference

* `id` - The id of the sakuracloud_enhanced_db.
* `hostname` - The name of database host. This will be built from `database_name` + `tidb-is1.db.sakurausercontent.com`.
* `max_connections` - The value of max connections setting.
