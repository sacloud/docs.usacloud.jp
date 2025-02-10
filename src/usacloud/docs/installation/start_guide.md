# Usacloud導入ガイド

---

### インストール {: #install }

#### macOS/Linux

```bash
curl -fsSL https://github.com/sacloud/usacloud/releases/latest/download/install.sh | bash
```

#### macOS/Linux (Homebrew)

```bash
brew tap sacloud/usacloud; brew install usacloud
```

---

#### Windows(`chocolatey`)

```bash
choco install usacloud
```

> chocolateyの[usacloudパッケージ](https://chocolatey.org/packages/usacloud)は @223n さんによってメンテナンスされています。

---

#### その他の場合

GitHub Releasesページから任意のプラットフォーム向けのファイルをダウンロードして展開し、任意のフォルダー内に配置してください。  
(PATHを通しておくと便利です)

[https://github.com/sacloud/usacloud/releases/latest/](https://github.com/sacloud/usacloud/releases/latest/)

---

#### Dockerを利用する場合

`usacloud`実行用イメージとして`ghcr.io/sacloud/usacloud`を公開しています。

```bash
# Dockerでのusacloud実行例
docker run -it --rm \
    -e SAKURACLOUD_ACCESS_TOKEN \
    -e SAKURACLOUD_ACCESS_TOKEN_SECRET \
    -e SAKURACLOUD_ZONE \
    ghcr.io/sacloud/usacloud server ls
```

!!! warning
    v0との互換性維持のためにDockerHubで`sacloud/usacloud`イメージを配布していますが将来的に廃止予定です。  
    `ghcr.io/sacloud/usacloud`の利用を推奨します。


---

#### シェル補完(Shell Completion) {: #shell_completion }

`bash_completion`などのシェル補完が利用できる場合は、以下のコマンドで有効に出来ます。

##### Bash

    # Linuxの場合
    $ usacloud completion bash > /etc/bash_completion.d/usacloud

    # MacOSの場合
    $ usacloud completion bash > /usr/local/etc/bash_completion.d/usacloud

##### Zsh

    $ usacloud completion zsh > "${fpath[1]}/_usacloud"

##### Fish:

    $ usacloud completion fish > ~/.config/fish/completions/usacloud.fish

詳細は[completionコマンド](../../guides/completion)を参照してください。

---


### 設定 {: #configuration }

`usacloud`の実行にはさくらのクラウドのAPIキーの取得/設定が必要です。
以下のドキュメントに従いAPIキーを作成してください。

[さくらのクラウド ドキュメント: APIキーの新規作成・編集](https://manual.sakura.ad.jp/cloud/api/apikey.html#id3)


#### APIキーの設定

APIキーを取得したら、`usacloud config`を実行しAPIキーを設定します。

画面の指示に従い、アクセストークン(token)とシークレット(secret)、操作対象のゾーン、デフォルトの出力形式を入力します。

```bash
$ usacloud config

  Setting SakuraCloud API Token => 
  	Enter token: [アクセストークンを入力]

  Setting SakuraCloud API Secret => 
  	Enter secret: [アクセスシークレットを入力]
    	
  Setting SakuraCloud Zone => 
  	Enter zone[is1a/is1b/tk1a/tk1b/tk1v]: [ゾーンを入力]
  
  Setting Default Output Type => 
	Enter default-output-type[table/json/yaml]: [デフォルトの出力形式を入力]
	
  Written your settings to ~/.usacloud/default/config.json
```

操作対象のゾーンは以下のいずれかを入力してください。

  * `is1a` : 石狩第1ゾーン
  * `is1b` : 石狩第2ゾーン
  * `tk1a` : 東京第1ゾーン
  * `tk1b` : 東京第2ゾーン
  * `tk1v` : サンドボックス

!!! note
    グローバルオプション`--zones`やプロファイルで`Zones`を設定している場合は設定可能なゾーンが上記と異なる場合があります。  
    詳細は[リファレンス / プロファイル](../../references/profile)を参照してください。
  
!!! warning
    `usacloud config`コマンドで入力した内容は平文でJSONファイルとして保存されます。  
    デフォルトでは`~/.usacloud/<ファイル名>/config.json`にパーミッション`0700`で保存されます。  
    取り扱いは十分に注意してください。

!!! tip
    `usacloud config`では基本的な項目の設定のみが行えます。  
    より詳細な設定をしたい場合は生成されたJSONファイルを直接編集する必要があります。  
    JSONファイルに記載できる内容の詳細については[リファレンス / プロファイル](../../references/profile)を参照してください。

#### その他のAPIキー設定方法

##### 環境変数での指定

APIキーは環境変数での指定にも対応しています。

```bash
$ export SAKURACLOUD_ACCESS_TOKEN=アクセストークン
$ export SAKURACLOUD_ACCESS_TOKEN_SECRET=アクセスシークレット
$ export SAKURACLOUD_ZONE=ゾーン
```

##### コマンドラインオプションでの指定

コマンド実行時にコマンドラインオプションで指定することが出来ます。

```bash
$ usacloud --token=アクセストークン --secret=アクセスシークレット --zone=ゾーン server ls
```

!!! warning
    コマンドラインオプション`--token`/`--secret`を利用した場合、ヒストリーに値が残ってしまう場合があります。  
    取り扱いは十分に注意してください。

##### 複数箇所で指定した場合の優先順位

複数の箇所で指定されていた場合、以下の順で読み込みます(後から読み込んだものが優先)。

1. 環境変数での指定
2. プロファイル(`usacloud config`で保存されるもの)での指定
3. コマンドラインオプションでの指定

--- 

以上で設定終了です。続いて[基本的な使い方](../../guides/basic_usage)に進んでください。
