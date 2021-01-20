# 基本的な使い方

---

## コマンド基本構文

`usacloud`コマンドの基本構文は以下の通りです。

```bash
$ usacloud <操作対象のリソース> <コマンド> [コマンドオプション] [引数]
```

#### 指定できる値

リソースやコマンド、オプションに指定できる値は[help表示](#help)で確認できます。

#### コマンド実行例

```bash
#------------------------------------------------------------------------------
# サーバー(server)に対する一覧表示コマンド(ls)の場合の例
#------------------------------------------------------------------------------

# 基本的な使い方(オプション/引数なし)
$ usacloud server ls

# グローバルオプションあり
$ usacloud --zone tk1a server ls

# オプション(短い形式)
$ usacloud server ls -q

# オプション(長い形式)
$ usacloud server ls --quiet

# オプションは=を明示してもOK
$ usacloud server ls --name=foovar
```

---

## help表示

`-h`または`--help`フラグを指定するとヘルプを表示します。   
フラグを指定する位置で表示できる内容が変化します。

#### グローバルオプション/操作対象のリソースのヘルプ表示

```bash
usacloud -h
```

#### コマンドのヘルプ表示

```bash
#
# 書式: usacloud <操作対象のリソース> -h
#

# サーバー(server)のヘルプ表示の例
usacloud server -h
```

#### コマンドオプション/引数のヘルプ表示

```bash
#
# 書式: usacloud <操作対象のリソース> <コマンド> -h
#

# サーバー(server1)の一覧表示コマンド(ls)のヘルプ表示の例
usacloud server ls -h
```

--- 

## グローバルオプション

主なオプションを以下に記載します。全てのオプションについては[グローバルオプション](../../references/global)を参照してください。

---

#### コンフィグ(`--config`)

利用するコンフィグ(プロファイル)を指定します。(エイリアス:`--profile`)  
指定可能な値は`usacloud config list`コマンドで調べることが可能なほか、`usacloud config create`コマンドなどで新規作成も可能です。

> 通常この値は`~/.usacloud/current`の値が利用されます。  
> 環境変数`SAKURACLOUD_PROFILE`/`USACLOUD_PROFILE`での指定、またはコマンド実行時の`--profile`の指定でこの設定を上書き可能です。

!!! Warning
    Usacloud v0との互換性維持のためv1でも環境変数`USACLOUD_PROFILE`が利用可能ですが、将来のバージョンでは廃止される予定です。

---

#### APIトークン(`--token`)

さくらのクラウドのAPIトークンを指定します。  

> 通常この値は`~/.usacloud/[current-profile-nane]/config.json`の値が利用されます。  
> 環境変数`SAKURACLOUD_ACCESS_TOKEN`での指定、またはコマンド実行時の`--token`の指定でこれらの設定を上書き可能です。  

---

#### APIシークレット(`--secret`)

さくらのクラウドのAPIシークレットを指定します。  

> 通常この値は`~/.usacloud/[current-profile-nane]/config.json`の値が利用されます。  
> 環境変数`SAKURACLOUD_ACCESS_TOKEN_SECRET`での指定、またはコマンド実行時の`--secret`の指定でこれらの設定を上書き可能です。  

---

## 共通オプション: 出力の設定

出力の行われるコマンドでは以下の出力オプションが利用可能です。  
(`bill csv`などの一部コマンドでは出力オプションを利用できない場合があります)  

---

#### 出力タイプ(`--output-type` or `--out`)

出力形式を選択します。指定可能な値は以下のいずれかです。  

* `table` : テーブル形式
* `json`  : JSON形式
* `yaml`  : YAML形式

未指定の場合はグローバルオプション`--default-output-type`の設定が利用されます。

---
 
#### quietモード(`--quiet` or `-q`)

IDのみ出力します。

**このオプションは`--output-type`と一緒に指定できません。 **

---

#### フォーマット(`--format` or `--fmt`)

出力フォーマットをgo言語の[text/template](https://golang.org/pkg/text/template/)形式で指定します。

```bash
usacloud server ls --format "ID is {{.ID}}, Name is {{.Name}}"
```

#### クエリ(`--query` | `--query-driver`)

[JMESPath](https://jmespath.org)または[jq](https://stedolan.github.io/jq/)で出力の加工が行えます。  

##### 利用例(JMESPath):

```sh
$ usacloud server list --query "[].Name"
[
    "server1",
    "server2",
    "server3"
]
```

##### 利用例(jq):

```sh
$ usacloud server list --query-driver jq --query ".[].Name"
"server1"
"server2"
"server3"
```

`--query`と`--query-driver`の詳細は[クエリ](../query)を参照してください。

---

## 共通オプション: ゾーン指定

ゾーンを指定する必要があるリソースの場合`--zone`で指定します。

```bash
$ usacloud server list --zone is1a
```

プロファイルでゾーンをセットしている場合は省略可能です。

### 全ゾーン一括操作

`--zone`に`all`を指定することで全ゾーン一括操作が可能です。

```bash
# 全ゾーンのサーバを一覧表示
$ usacloud server list --zone=all

# 全ゾーンのサーバのうち、名称にexampleを含むサーバをシャットダウン
$ usacloud server shutdown --zone=all example

# 全ゾーンにサーバ作成
$ usacloud server create --name example ... --zone=all
```


---

## 共通オプション: ファイル or JSONでのパラメータ指定(`--parameters`)

コマンドに渡すパラメータをJSONまたはJSONを記述したファイルパスで指定します。

```bash
# 文字列で指定する例
$ usacloud server list --parameters '{"Names": ["example"]}'

# ファイルパスで指定する例
$ cat example.json
{
  "Names": ["example"]
}
$ usacloud server list --parameters example.json
```

JSONファイルは`--example`パラメータで記述例を確認出来ます。

!!! tip
    `--parameters`はコマンドラインオプションとの併用/コマンドラインオプションでの上書きが可能です。  
    共通的なパラメータをファイルに保存しておき、個別の値はコマンドラインで指定する、という使い方が出来ます。

--- 

## 共通オプション: パラメータ例の出力(`--example`)

`--parameters`で指定するJSONファイルの例を出力します。

```bash
$ usacloud switch create --example
{
    "Zone": "tk1a | tk1b | is1a | is1b | tk1v",
    "Name": "example",
    "Description": "example",
    "Tags": [
        "tag1=example1",
        "tag2=example2"
    ],
    "IconID": 123456789012
}
```

通常はファイルなどに保存した上で編集して利用します。

```bash
# パラメータ例をファイルに出力
$ usacloud switch create --example > parameters.json
# 編集
$ vi parameters.json
# 利用
$ usacloud switch create --parameters parameters.json
```


## 共通オプション: yesオプション(`-y` or `--assumeyes`)

実行時に確認ダイアログが表示されるコマンドで利用可能です。  
確認ダイアログ全てに`y` または `yes`を入力します。  

## 引数: ID or 名称 or タグでの指定

特定のリソースに対するコマンドの場合、ID、名称、またはタグを引数にとります。  
IDとタグの場合は完全一致、名称の場合は部分一致したリソースが操作対象となります。

!!! warning
    複数リソースの一括操作に対応していないコマンドの場合、対象が複数となる指定はエラーとなります。

例:

```bash
#------------------------------------------------------------------------------
# 以下のリソースが存在する場合の例
#------------------------------------------------------------------------------
$ usacloud server ls
+--------------+---------+-----+--------+---------------+--------+
|      ID      |  NAME   | CPU | MEMORY |   IPADDRESS   | STATUS |
+--------------+---------+-----+--------+---------------+--------+
| 000000000011 | Test1-1 | 1   | 1024MB | 192.0.2.11/24 | up     |
| 000000000021 | Test2-1 | 1   | 1024MB | 192.0.2.21/24 | up     |
| 000000000031 | Test3-1 | 1   | 1024MB | 192.0.2.31/24 | up     |
| 000000000032 | Test3-2 | 1   | 1024MB | 192.0.2.32/24 | up     |
+--------------+---------+-----+--------+---------------+--------+

#------------------------------------------------------------------------------
# 部分一致(例1)
#------------------------------------------------------------------------------
$ usacloud server boot Test # 名称にTestを含むもの

Target resource IDs => [
	000000000011,
	000000000021,
	000000000031,
	000000000032
]
Are you sure you want to boot?(y/n) [n]:

#------------------------------------------------------------------------------
# 部分一致(例2)
#------------------------------------------------------------------------------
$ usacloud server boot Test3 # 名称にTest3を含むもの

Target resource IDs => [
	000000000031,
	000000000032
]
Are you sure you want to boot?(y/n) [n]:
```

### `read`/`list`コマンドの使い分け

Usacloudではリソースの情報を参照するためのサブコマンドとして`list`と`read`を多くのリソースで提供しています。  
これらの違いは以下のとおりです。

- 複数件ヒットを許容するか
- 対象リソースの指定方法

#### `read`の特徴

- 複数件ヒットした場合はエラーとなる
- 対象リソースの指定は引数で行う

#### `list`の特徴

- 複数件ヒットしてもエラーとならない
- 対象リソースの指定はフラグ(オプション)で行う

!!! Tips
    `read`は他のコマンドとの組み合わせて利用可能になっています。  
    例: アイコンを名前で検索し、IDをスイッチ作成のパラメータに渡す(アイコンが複数ヒットしたらエラーとなる)  
    `usacloud switch create --icon-id=$(usacloud icon read -q example)`
