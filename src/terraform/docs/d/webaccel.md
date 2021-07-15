# ウェブアクセラレータサイト情報: sakuracloud_webaccel

ウェブアクセラレータのサイト情報を参照するためのデータソース

## Example Usage

```tf
# サイト情報を取得
data sakuracloud_webaccel "site" {
  name = "your-site-name"
  # or
  # domain = "your-domain"
}
```

<div class="editor">

<h2><a href="https://zouen-alpha.usacloud.jp/#data/webaccel" target="_blank" rel="noopener noreferrer">Code Editor</a></h2>

<iframe src="https://zouen-alpha.usacloud.jp/#data/webaccel"></iframe>

</div>


## Argument Reference

* `name` - (Optional) 対象サイトの名前
* `domain` - (Optional) 対象サイトのドメイン名

## Attribute Reference

* `id` - ID
* `domain_type` 
* `has_certificate` 
* `host_header` 
* `origin` 
* `site_id`
* `status` 
* `subdomain` 
  
* `cname_record_value`
* `txt_record_value` 

