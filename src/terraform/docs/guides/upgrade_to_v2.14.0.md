# アップグレードガイド(v2.14)

## 目次

- [GPUプラン(高火力プラン)対応](#diff1)
  
### GPUプラン(高火力プラン)対応 {: #diff1 }

サーバ作成時にGPUプランを指定可能になりました。
`usacloud server-plan list`コマンドなどでGPUプランの情報を参照し、`core`、`memory`、`gpu`パラメータでサーバプランを指定することで利用可能です。

!!!info
   現在は`is1a`ゾーンでのみGPUプランが提供されています


利用例:

```tf
resource "sakuracloud_server" "foobar" {
  zone = "is1a" 

  name   = "example"

  # 2021/10現在はis1aゾーンにて"GPUプラン/4Core-56GB-1GPU"のみが提供されている
  core   = 4
  memory = 56
  gpu    = 1

  # ...
}
```