# アップグレードガイド(v2.11)

## 目次

- [@previous-id特殊タグのサポート](#diff1)
  
### @previous-id特殊タグのサポート {: #diff1 }

サーバ/ルータ/エンハンスドロードバランサでプラン変更時にリソースIDが変わった場合でも、変更前のIDが@previous-idタグに保持されていればTerraformから追跡可能になりました。
この機能は主に以下のようなツールとの相互運用のためのものです。

- [sacloud/usacloud](https://github.com/sacloud/usacloud): v1.3+
- [sacloud/autoscaler](https://github.com/sacloud/autoscaler): v0.2+

これらのツールで対象リソースのプランを変更した場合、`terraform apply -refresh-only`などを実行することでプラン変更に伴ってIDが変更されたリソースを追跡可能です。  