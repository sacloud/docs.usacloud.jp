# Examples: ELBの垂直スケール

## 概要

ELBの垂直スケール(CPS変更)を行います。  
あらかじめ定義した範囲の中でCPSを上下させます。  

!!! tips
    ELBのオートスケールは無停止/サービス中断なしで行えます。

## 構成例

以下の条件で垂直スケールさせる例です。

- 対象ELB:
    - example1
- プランはデフォルトの範囲とする

```yaml
resources:
  - type: ELB
    name: "elb"
    selector:
      names: ["example1"]
      
#デフォルトのプラン 
#    plans:
#      - cps: 100
#      - cps: 500
#      - cps: 1000
#      - cps: 5000
#      - cps: 10000
#      - cps: 50000
#      - cps: 100000
#      - cps: 400000
```

!!! info
リソース定義が1つだけなため、Inputsからのリクエスト時に`resource-name`パラメータを省略可能です。

    例:  
    Webhook系のリクエストURL例: `http://<your-host>/up`  
    Direct Inputsの実行例: `autoscaler inputs direct up`  

