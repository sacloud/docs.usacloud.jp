# サーバ: sakuracloud_server

## Example Usage

```tf
resource "sakuracloud_server" "foobar" {
  name        = "foobar"
  disks       = [sakuracloud_disk.foobar.id]
  description = "description"
  tags        = ["tag1", "tag2"]

  network_interface {
    upstream         = "shared"
    packet_filter_id = data.sakuracloud_packet_filter.foobar.id
  }

  disk_edit_parameter {
    hostname        = "hostname"
    password        = "password"
    disable_pw_auth = true

    # ssh_key_ids     = ["<ID>", "<ID>"]
    # note {
    #  id         = "<ID>"
    #  api_key_id = "<ID>"
    #  variables = {
    #    foo = "bar"
    #  }
    # }
  }
}

data "sakuracloud_packet_filter" "foobar" {
  filter {
    names = ["foobar"]
  }
}

data "sakuracloud_archive" "ubuntu" {
  os_type = "ubuntu"
}

resource "sakuracloud_disk" "foobar" {
  name              = "{{ .arg0 }}"
  source_archive_id = data.sakuracloud_archive.ubuntu.id
}
```

<div class="editor">

<h2><a href="https://zouen-alpha.usacloud.jp/#resource/server" target="_blank" rel="noopener noreferrer">Code Editor</a></h2>

<iframe src="https://zouen-alpha.usacloud.jp/#resource/server"></iframe>

</div>


## Argument Reference

* `name` - (Required) 名前 / `1`-`64`文字で指定
* `cdrom_id` - (Optional) サーバに挿入するCD-ROM(ISOイメージ)のID
* `force_shutdown` - (Optional) `terraform apply`時にAPI経由でシャットダウン、または再起動する際に強制終了するフラグ  
ACPIが利用できないサーバの場合`true`に設定する

#### スペック関連

* `commitment` - (Optional) vCPUの割り当て方法 / 次のいずれかを指定 
    - `standard`(デフォルト): 通常
    - `dedicatedcpu`: コア専有
* `core` - (Optional) vCPUの割り当て数 / デフォルト:`1`
* `memory` - (Optional) メモリサイズ(GiB単位) / デフォルト:`1`
* `gpu` - (Optional) GPUの割り当て数 
* `network_interface` - (Optional) NIC設定のリスト。詳細は[network_interfaceブロック](#network_interface)を参照
* `interface_driver` - (Optional) NICのドライバー / 次のいずれかを指定［`virtio`/`e1000`]/ デフォルト:`virtio`
* `private_host_id` - (Optional) 専有ホストのID

!!! Note
    `core`と`memory`、`gpu`に指定できる値の組み合わせはさくらのクラウドドキュメントなどを参照ください。  
    `usacloud server-plan ls`コマンドでも確認できます。

!!! Note
    `network_interface`は省略可能ですが、省略した場合NICが接続されていない状態のサーバが作成されます。  
    通常は1つ以上指定してください。
    
##### network_interfaceブロック

* `upstream` - (Required) 上流ネットワーク設定 / 次のいずれかを指定する
    - `shared`: 共有セグメント(100Mbps)
    - `disconnect`: 切断
    - `<switch id>`: スイッチのID
* `packet_filter_id` - (Optional) NICにアタッチするパケットフィルタのID
* `user_ip_address` - (Optional) 表示用IPアドレス / `upstream`にスイッチIDが指定されている時のみ有効 / この項目は表示用で実際のサーバのNIC設定には影響しない


#### ディスク関連

* `disks` - (Optional) サーバに接続するディスクのIDのリスト
* `disk_edit_parameter` - (Optional) ディスクの修正APIへのパラメータ。詳細は[disk_edit_parameterブロック](#disk_edit_parameter)を参照。`user_data`と同時に指定できません
* `user_data` - (Optional) cloud-initでのUserData。 `disk_edit_parameter`と同時に指定できません

##### disk_edit_parameterブロック

* `change_partition_uuid` - (Optional) パーティションUUIDを変更するフラグ
* `disable_pw_auth` - (Optional) パスワード認証を無効にするフラグ
* `enable_dhcp` - (Optional) DHCPクライアントを有効にするフラグ
* `gateway` - (Optional) ゲートウェイIPアドレス
* `hostname` - (Optional) ホスト名 / `1`-`64`文字で指定
* `ip_address` - (Optional) IPアドレス
* `netmask` - (Optional) サブネットマスク長
* `note_ids` - (Optional/Deprecated) スタートアップスクリプトIDのリスト  
* `note` - (Optional) スタートアップスクリプト。詳細は[noteブロック](#note)を参照
* `password` - (Optional) 管理ユーザーのパスワード / `8`-`64`文字で指定
* `ssh_key_ids` - (Optional) SSH公開鍵IDのリスト
* `ssh_keys` - (Optional) SSH公開鍵IDのリスト

!!! Note
    ディスクの修正API(`disk_edit_parameter`)はサーバに接続された先頭のディスクに対してのみ有効です。
    
!!! Note
    `note_ids`は将来のバージョンで削除される予定です。代わりに`note`をご利用ください。
    
##### noteブロック

* `id` - (Required) スタートアップスクリプトのID
* `api_key_id` - (Optional) スタートアップスクリプトに埋め込むAPIキーのID
* `variables` - (Optional) スタートアップスクリプトの埋め込み変数に指定する値 / map形式、mapの値は文字列で指定

#### Common Arguments

* `description` - (Optional) 説明 / `1`-`512`文字で指定
* `icon_id` - (Optional) アイコンID
* `tags` - (Optional) タグ
* `zone` - (Optional) リソースを作成する対象ゾーンの名前(例: `is1a`, `tk1a`) / この値を変更するとリソースの再作成が行われる

#### Timeouts

`timeouts`ブロックで[カスタムタイムアウト](https://www.terraform.io/docs/configuration/resources.html#operation-timeouts)が設定可能です。  

* `create` - 作成 (デフォルト: 5分)
* `update` - 更新 (デフォルト: 5分)
* `delete` - 削除 (デフォルト: 20分)

## Attribute Reference

* `id` - ID
* `dns_servers` - DNSサーバのIPアドレスのリスト
* `gateway` - ゲートウェイIPアドレス
* `hostname` - ホスト名
* `ip_address` - IPアドレス
* `netmask` - サブネットマスク長
* `network_address` - ネットワークアドレス
* `private_host_name` - 専有ホストの名前

`network_interface`の各要素は以下の項目も参照可能です。

* `mac_address` - MACアドレス

## Import

IDを指定する事でインポート可能です。

```bash
$ terraform import sakuracloud_server.example 123456789012
```