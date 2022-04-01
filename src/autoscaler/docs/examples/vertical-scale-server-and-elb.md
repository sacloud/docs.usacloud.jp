# Examples: ELB + サーバの垂直スケール

## 概要

ELB配下のサーバの垂直スケール(プラン変更)を行います。  
Inputsからパラメータ`resource-name`を指定することでELBまたはサーバのプラン変更が可能です。  

ELB配下に指定したサーバのIPアドレスがELBに実サーバとして登録されている場合は以下のように処理されます。  

- &lt;各サーバを順次処理&gt;
    - ELBからデタッチ
    - サーバのプラン変更(再起動を伴います)   
    - ELBへアタッチ

!!! warning
    ELB+サーバのオートスケールは無停止/サービス中断なしで行えますが、そのためには実サーバが2台以上必要です。  
    実サーバが2台未満の場合はサーバが再起動する間にサービス中断が発生する可能性があります。  
    また、サーバの垂直スケール後に準備が整わないままサービスインさせないように`setup_grace_period`を適切に指定しておく必要があります(デフォルトは60秒です)。

!!! info
    ELBからのデタッチ/アタッチはELBの実サーバごとに`Enabled`というプロパティを更新することで行われます。  
    この際に元の`Enabled`の値は考慮されません。スケールアップ/ダウン前から`Enabled=false`であってもELBにアタッチする際に`Enabled=true`へ更新されます。  

## 構成例

以下の条件でサーバを垂直スケールさせる例です。

- 対象エンハンスドロードバランサ:
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
      type: ELB
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

