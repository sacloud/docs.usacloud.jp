# アップグレードガイド(v2.8)

## 目次

- [Terraform Plugin SDK v2対応](#diff1)
- [サーバのディスクの修正時に公開鍵を文字列で指定](#diff2)
- [SIMのパスコードを`Sensitive:true`に変更](#diff3)
- [シンプル監視でのHTTP/2の利用](#diff4)    
- [シンプル監視でのコンテンツボディ監視](#diff5)
- [エンハンスドロードバランサでのgzipの利用](#diff6)
- [エンハンスドロードバランサのLet's Encrypt設定 - SANs指定機能](#diff7)

### Terraform Plugin SDK v2対応(#diff1)

このバージョンからTerraform Plugin SDK v2に対応しました。  
これに伴いTerraform v0.11以前ではこのプロバイダーを利用できなくなりました。  
Terraform v0.12以降をご利用ください。

### サーバのディスクの修正時に公開鍵を文字列で指定(#diff2)

サーバのディスクの修正パラメータを指定する際、公開鍵をIDだけでなく文字列でも指定可能になりました。

利用例:

```hcl
resource "sakuracloud_server" "example" {
  name        = "example"

  network_interface {
    upstream = "shared"
  }

  disk_edit_parameter {
    ssh_keys = [file("~/.ssh/gitlab.pub")] # 公開鍵を文字列で指定
    ssh_key_ids = [sakuracloud_ssh_key.foobar.id] # 公開鍵をリソースIDで指定
  }
}
```

### SIMのパスコードを`Sensitive:true`に変更(#diff3)

tfファイル上の変更は不要です。

### シンプル監視でのHTTP/2の利用(#diff4)

シンプル監視のHTTP監視時にHTTP/2が利用可能になりました。(v2.8.2で対応)

利用例:

```hcl
resource "sakuracloud_simple_monitor" "foobar" {
  target = "www.example.com"

  delay_loop = 60
  health_check {
    protocol    = "https"
    port        = 443
    path        = "/"
    status      = "200"
    host_header = "example.com"
    sni         = true
    
    http2       = true # 追加
  }
  notify_email_enabled = true
}
```

### シンプル監視でのコンテンツボディ監視(#diff5)

シンプル監視でのHTTP監視時にコンテンツボディのチェックが利用可能になりました。  

利用例:

```hcl
resource "sakuracloud_simple_monitor" "foobar" {
  target = "www.example.com"

  delay_loop = 60
  health_check {
    protocol    = "https"
    port        = 443
    path        = "/"
    status      = "200"
    host_header = "example.com"
    sni         = true
    
    contains_string = "ok" #追加
  }
  notify_email_enabled = true
}
```

### エンハンスドロードバランサでのgzipの利用(#diff6)

エンハンスドロードバランサでコンテンツのgzip圧縮を有効化できるようになりました。

利用例:

```hcl
resource "sakuracloud_proxylb" "foobar" {
  # 中略
  gzip = true
}
```

### エンハンスドロードバランサのLet's Encrypt設定 - SANs指定機能(#diff7)

エンハンスドロードバランサでLet's Encryptを用いて証明書を発行する際のパラメータとしてSANs(Subject Alternate Names)を指定可能になりました。  

利用例:

```hcl
resource sakuracloud_proxylb_acme "foobar" {
  proxylb_id        = sakuracloud_proxylb.foobar.id
  accept_tos        = true
  common_name       = "www.example.com"
  subject_alt_names = ["www1.example.com"] #追加
  
  update_delay_sec = 120
}
```