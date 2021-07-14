# Examples: サーバの垂直スケール

## 概要

サーバの垂直スケール(プラン変更)を行います。  
あらかじめ定義した範囲の中でCPU/メモリサイズの組み合わせを上下させます。  

!!! info
    サーバのプラン変更時にはサーバの再起動が必要です。
    このため、インフラ構成によってはサービス停止が発生します。
    Webサーバのような外部からアクセスされるようなサービスを稼働させている場合はELBやLBとの組み合わせを検討してください。  
    
    参考:  
      - [垂直スケール: サーバ+エンハンスドロードバランサ](../vertical-scale-server-and-elb/)  
      - [垂直スケール: サーバ+ロードバランサ](../vertical-scale-server-and-lb/)  

## 構成例

以下の条件でサーバを垂直スケールさせる例です。

- 対象サーバ:
    - is1aゾーンのexample1とexample2
- プランは以下の範囲とする
    - Core:1 / メモリ:  1GB
    - Core:2 / メモリ:  4GB
    - Core:4 / メモリ:  8GB

```yaml
resources:
  - type: Server
    name: "servers"
    selector:
      names: ["example"] # 名前に'example'が含まれているリソースが操作対象となる
      zones: ["is1a"]
      
    plans:
      - core: 1
        memory: 1
      - core: 2
        memory: 4
      - core: 4
        memory: 8
```

!!! Info
リソース定義が1つだけなため、Inputsからのリクエスト時に`resource-name`パラメータを省略可能です。

    例:  
    Webhook系のリクエストURL例: `http://<your-host>/up`  
    Direct Inputsの実行例: `autoscaler inputs direct up`  

