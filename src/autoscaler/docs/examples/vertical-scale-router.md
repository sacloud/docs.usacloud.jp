# Examples: ルータの垂直スケール

## 概要

ルータの垂直スケール(帯域幅変更)を行います。  
あらかじめ定義した範囲の中で帯域幅を上下させます。  

!!! tips
ルータのオートスケールは無停止/サービス中断なしで行えます。

## 構成例

以下の条件で垂直スケールさせる例です。

- 対象ルータ:
    - is1aゾーンのexample1
- プランはデフォルトの範囲とする

```yaml
resources:
  - type: Router
    name: "router"
    selector:
      names: ["example1"]
      zones: ["is1a"]
      
# デフォルトのプラン 
#    plans:
#      - band_width: 100
#      - band_width: 250
#      - band_width: 500
#      - band_width: 1000
#      - band_width: 1500
#      - band_width: 2000
#      - band_width: 2500
#      - band_width: 3000
#      - band_width: 3500
#      - band_width: 4000
#      - band_width: 4500
#      - band_width: 5000
```

!!! tips
    東京第2ゾーンでは5,500Mbps〜10,000Mbpsプランも利用可能です。  
    利用したい場合は`plans`を指定してください。

!!! info
リソース定義が1つだけなため、Inputsからのリクエスト時に`resource-name`パラメータを省略可能です。

    例:  
    Webhook系のリクエストURL例: `http://<your-host>/up`  
    Direct Inputsの実行例: `autoscaler inputs direct up`  

