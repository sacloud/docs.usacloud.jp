# ウェブアクセラレータ アクセス制御リスト(ACL): sakuracloud_webaccel_acl

## Example Usage

```tf
data sakuracloud_webaccel "site" {
   name = "your-site-name"
   # or
   # domain = "your-domain"
 }
 resource sakuracloud_webaccel_acl "acl" {
   site_id = data.sakuracloud_webaccel.site.id
   acl = join("\n", [
     "deny 192.0.2.5/25",
     "deny 198.51.100.0",
     "allow all",
   ])
 }
```

<div class="editor">

<h2><a href="https://zouen-alpha.usacloud.jp/#resource/webaccel_acl" target="_blank" rel="noopener noreferrer">Code Editor</a></h2>

<iframe src="https://zouen-alpha.usacloud.jp/#resource/webaccel_acl"></iframe>

</div>

## Argument Reference

* `site_id` - (Required) サイトのID
* `acl` - (Required) アクセス制御リストのルール、1行1ルールとして記載する

参考: https://manual.sakura.ad.jp/cloud/webaccel/manual/settings-acl.html

## Attribute Reference

* `id` - ID
