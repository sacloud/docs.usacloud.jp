## Inputs共通設定

各Inputsは`--config`というパラメータでExporterなどを設定を記述したファイルへのパスを指定可能です。

利用例:

```bash
$ autoscaler inputs grafana --addr 192.0.2.1:443 --config your-config.yaml
```

設定ファイルの書式は以下の通りです。

```yaml
# Exporterの設定
exporter_config:
  enabled: <bool>
  address: <string | default=":8081">
```