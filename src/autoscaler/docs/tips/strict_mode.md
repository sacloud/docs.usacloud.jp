## 共有サーバでの実行(strictモード)

共有サーバやマルチテナントで稼働させる場合などのAutoScalerのインスタンスを同一環境で複数稼働させる環境において、
外部ファイルへのアクセスを制限する`strictモード`を利用可能です。  

!!! warning
    strictモードは全ての外部ファイルアクセスを制限するものではなく、  
    特定のファイルアクセスパターンを無効にするものです。  
    必要に応じて実行ユーザーに適切な権限だけ付与するといった対応などと組み合わせてご利用ください。

## 利用方法

Coreの起動時に`--strict`を指定することでstrictモードが有効になります。

```bash
$ autoscaler start --strict
```

## strictモードで制限されるもの

コンフィギュレーションの以下項目の挙動が変更されます。

- `handlers`: 指定不可
- `autoscaler.exporter`: 指定不可
- `sakuracloud.profile`: 指定不可
- 文字列またはファイルパスを指定可能な項目: 文字列のみ指定可能
    - サーバグループ
        - `template`
            - `edit_parameter`
                - `startup_scripts` 
                - `ssh_keys`
            - `cloud_config`

!!!info
  libsacloudのプロファイル機能が無効になるため、環境変数`SAKURACLOUD_PROFILE`や`USACLOUD_PROFILE`を指定しても無視されるようになります