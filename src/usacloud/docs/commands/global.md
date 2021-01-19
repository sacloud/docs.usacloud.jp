# コマンドリファレンス / グローバルオプション
---

`usacloud`コマンドラインオプションとして指定可能なグローバルオプション。  

!!! info
    プロファイルを用いることでグローバルオプションでは指定できない項目の設定が行えます。  
    詳細は[コマンドリファレンス/プロファイル](../profile)を参照してください。

## グローバルオプション一覧

- [`--profile`](#profile)
- [`--token`](#token)
- [`--secret`](#secret)
- [`--zones`](#zones)
- [`--no-color`](#no_color)
- [`--trace`](#trace)
- [`--fake`](#fake)
- [`--fake-store`](#fake_store)
- [`--process-timeout-sec`](#process_timeout_sec)
- [`--argument-match-mode`](#argument_match_mode)
- [`--version`/`-v`](#version)
- [`--help`/`-h`](#help)

---

#### プロファイル(`--profile`) {: #profile }

利用するプロファイル(コンフィグ)を指定します。(エイリアス:`--config`)  
指定可能な値は`usacloud profile list`コマンドで調べることが可能なほか、`usacloud profile create`コマンドなどで新規作成も可能です。

> 通常この値は`~/.usacloud/current`の値が利用されます。  
> 環境変数`SAKURACLOUD_PROFILE`/`USACLOUD_PROFILE`での指定、またはコマンド実行時の`--profile`の指定でこの設定を上書き可能です。

!!! Warning
    Usacloud v0との互換性維持のためv1でも環境変数`USACLOUD_PROFILE`が利用可能ですが、将来のバージョンでは廃止される予定です。

---

#### APIトークン(`--token`) {: #token }

さくらのクラウドのAPIトークンを指定します。

> 通常この値は`~/.usacloud/[current-profile-nane]/config.json`の値が利用されます。  
> 環境変数`SAKURACLOUD_ACCESS_TOKEN`での指定、またはコマンド実行時の`--token`の指定でこれらの設定を上書き可能です。

---

#### APIシークレット(`--secret`) {: #secret }

さくらのクラウドのAPIシークレットを指定します。

> 通常この値は`~/.usacloud/[current-profile-nane]/config.json`の値が利用されます。  
> 環境変数`SAKURACLOUD_ACCESS_TOKEN_SECRET`での指定、またはコマンド実行時の`--secret`の指定でこれらの設定を上書き可能です。

---

#### 操作対象ゾーン(`--zones`) {: #zones }

`usacloud`コマンドで操作可能なゾーンの一覧を指定します。  
ここでの指定は各コマンドでの`--zone`指定や`--zone=all`を指定した際の挙動に影響します。

省略した場合は以下の値が設定されます。

[libsacloud: types.ZoneNames](https://github.com/sacloud/libsacloud/blob/master/v2/sacloud/types/zone.go#L30-L31)

---

#### カラー出力の無効化(`--no-color`) {: #no_color }

端末への出力時にANSIエスケープシーケンスを用いたカラー出力を無効にします。

---

#### Fakeドライバの有効化(`--fake`) {: #fake }

さくらのクラウドAPI呼び出しにFakeドライバーを利用します。  
主にコマンドの書式確認などのテスト用途で利用します。

`--fake-store`オプションを指定しない場合はダミーAPIのデータストアはインメモリとなります。

---

#### FakeドライバでのJSONデータストアファイルパス(`--fake-store`) {: #fake_store }

Fakeドライバーが利用するデータストアのファイルパスを指定します。
この値を指定するとFakeドライバーがJSONデータストアを利用するようになります。

---

#### コマンド実行タイムアウト(`--process-timeout-sec`) {: #process_timeout_sec }

`usacloud`コマンド実行全体に対するタイムアウト秒数を指定します。  
未指定の場合は`2時間(7200)`が設定されます。

#### 引数とリソース名の比較方法(`--argument-match-mode`) {: #argument_match_mode }

操作対象を引数で指定するコマンドにおいてリソース名と引数を比較する方法を指定します。  
指定可能な値は以下のとおりです。

- `partial`(デフォルト): 部分一致
- `exact`: 完全一致

#### トレース出力(`--trace`) {: #trace }

さくらのクラウドAPI呼び出しのトレースログを標準エラーへ書き込みます。

---

#### バージョン表示(`--version` / `-v`) {: #version }

usacloudのバージョン情報を表示します。

---

#### ヘルプ表示(`--help` / `-h`) {: #help }

ヘルプを表示します。

