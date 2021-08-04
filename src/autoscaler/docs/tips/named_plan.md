## 名前付きプラン

ELB/ルータ/サーバ/サーバグループでは名前付きプランを利用可能です。

```yaml
# サーバのでの名前付きプランの例
plans:
  - core: 2
    memory: 4
    name: "low"
  - core: 4
    memory: 8
  - core: 4
    memory: 16
    name: "medium"
  - core: 8
    memory: 16
  - core: 10
    memory: 24
    name: "high"
  - core: 10
    memory: 32
  - core: 10
    memory: 48
```

プラン名はInputsからの`DesiredStateName`パラメータで指定されます。  
Coreは`DesiredStateName`が指定されていると以下のようにあるべき姿を算出します。

- Upリクエストがきた場合、現在のリソースのプランより大きな名前付きプランを返す
  見つからなかった場合はプラン変更せずエラーとする

- Downリクエストがきた場合、現在のリソースのプランより小さな名前付きプランを返す
  見つからなかった場合はプラン変更せずエラーとする
