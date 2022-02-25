# Examples: GSLB + サーバの垂直スケール

## 概要

GSLB配下のサーバの垂直スケール(プラン変更)を行います。  
Inputsからパラメータ`resource-name`を指定することでGSLBまたはサーバのプラン変更が可能です。  

GSLB配下に指定したサーバのIPアドレスがGSLBに実サーバとして登録されている場合は以下のように処理されます。  

- &lt;各サーバを順次処理&gt;
    - GSLBからデタッチ
    - サーバのプラン変更(再起動を伴います)   
    - GSLBへアタッチ

!!! info
    GSLBからのデタッチ/アタッチはGSLBの実サーバごとに`Enabled`というプロパティを更新することで行われます。  
    この際に元の`Enabled`の値は考慮されません。スケールアップ/ダウン前から`Enabled=false`であってもGSLBにアタッチする際に`Enabled=true`へ更新されます。  

## 構成例

以下の条件でサーバを垂直スケールさせる例です。

- 対象GSLB:
    - example
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
      
    parent:
      type: GSLB
      selector: "example"
      
    plans:
      - core: 1
        memory: 1
      - core: 2
        memory: 4
      - core: 4
        memory: 8
```

!!! info
リソース定義が1つだけなため、Inputsからのリクエスト時に`resource-name`パラメータを省略可能です。

    例:  
    Webhook系のリクエストURL例: `http://<your-host>/up`  
    Direct Inputsの実行例: `autoscaler inputs direct up`  

