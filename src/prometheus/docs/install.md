# インストール

## GitHub Releases

[GitHub Releases](https://github.com/sacloud/sakuracloud_exporter/releases/latest)から適切なファイルをダウンロードし展開します。

## Docker

Dockerイメージ `ghcr.io/sacloud/sakuracloud_exporter` を提供しています。  
以下のように利用します。

```bash
$ docker run -p 9542:9542 \
    -e SAKURACLOUD_ACCESS_TOKEN=<YOUR-TOKEN> \
    -e SAKURACLOUD_ACCESS_TOKEN_SECRET=<YOUR-SECRET> \ 
    ghcr.io/sacloud/sakuracloud_exporter 
```

## From source

Goの開発環境を用意した上で以下のコマンドを実行します。

```bash
$ go install github.com/sacloud/sakuracloud_exporter
```

