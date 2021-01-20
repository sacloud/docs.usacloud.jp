# クエリ / 出力の加工

---

[JMESPath](https://jmespath.org)または[jq](https://stedolan.github.io/jq/)で出力の加工が行えます。 

### クエリの使い方

以下の書式で実行します。

```bash
$ usacloud <リソース名> <コマンド> --query="<query>" [--query-driver=<"jmespath"|"jq">] [ID or Name or Tags]
```

- `--query`: JMESPathまたはjqに渡すクエリ(expression)
- `--query-driver`: `--query`を処理するドライバーの指定、`jmespath`(デフォルト)または`jq`が指定可能

### デフォルトのドライバーの切り替え

プロファイルの`DefaultQueryDriver`を指定することで`--query-driver`を省略した場合に利用するドライバーを指定可能です。  
詳細は[リファレンス/プロファイル](../../references/profile)を参照してください。  

### 利用例

```sh
# 環境変数経由でデフォルトドライバーを切り替え
$ export SAKURACLOUD_DEFAULT_QUERY_DRIVER=jq

$ usacloud server list --query ".[].Name"
"server1"
"server2"
"server3"
```

### `--query`以外の出力関連オプションとの併用

- `--quiet`/`-q`または`--format`を指定した場合、`--query`の指定は無視されます
- `--query`を指定した場合、`--output-type`の指定は無視されます