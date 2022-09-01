# パケットフィルタ(ルール): sakuracloud_packet_filter_rules

## Example Usage

```tf
resource "sakuracloud_packet_filter" "foobar" {
  name        = "foobar"
  description = "description"
}

resource "sakuracloud_packet_filter_rules" "rules" {
  packet_filter_id = sakuracloud_packet_filter.foobar.id

  expression {
    protocol         = "tcp"
    destination_port = "22"
  }

  expression {
    protocol         = "tcp"
    destination_port = "80"
  }

  expression {
    protocol         = "tcp"
    destination_port = "443"
  }

  expression {
    protocol = "icmp"
  }

  expression {
    protocol = "fragment"
  }

  expression {
    protocol    = "udp"
    source_port = "123"
  }

  expression {
    protocol         = "tcp"
    destination_port = "32768-61000"
  }

  expression {
    protocol         = "udp"
    destination_port = "32768-61000"
  }

  expression {
    protocol    = "ip"
    allow       = false
    description = "Deny ALL"
  }
}
```

<div class="editor">

<h2><a href="https://zouen-alpha.usacloud.jp/#resource/packet_filter_rules" target="_blank" rel="noopener noreferrer">Code Editor</a></h2>

<iframe src="https://zouen-alpha.usacloud.jp/#resource/packet_filter_rules"></iframe>

</div>

## Argument Reference

* `packet_filter_id` - (Required) ルールを設定するパケットフィルタのID / この値を変更するとリソースの再作成が行われる
* `expression` - (Optional) フィルタリングルールのリスト。詳細は[expressionブロック](#expression)を参照 / この値を変更するとリソースの再作成が行われる
* `zone` - (Optional) リソースを作成する対象ゾーンの名前(例: `is1a`, `tk1a`) / この値を変更するとリソースの再作成が行われる

##### expressionブロック

* `protocol` - (Required) プロトコル / 次のいずれかを指定［`http`/`https`/`tcp`/`udp`/`icmp`/`fragment`/`ip`]
* `allow` - (Optional) マッチしたパケットを許可するフラグ
* `destination_port` - (Optional) 宛先ポート、または宛先ポート範囲 (例:`1024`, `1024-2048`)
* `source_network` - (Optional) 送信元IPアドレス、または送信元CIDRブロック (例: `192.0.2.1`, `192.0.2.0/24`)
* `source_port` - (Optional) 送信元ポート番号、または送信元ポート番号範囲 (例: `1024`, `1024-2048`)
* `description` - (Optional) 説明

#### Timeouts

`timeouts`ブロックで[カスタムタイムアウト](https://www.terraform.io/docs/configuration/resources.html#operation-timeouts)が設定可能です。  

* `create` - 作成 (デフォルト: 5分)
* `delete` - 削除 (デフォルト: 5分)

## Attribute Reference

* `id` - パケットフィルタのID


## Import

IDを指定する事でインポート可能です。

```bash
$ terraform import sakuracloud_packet_filter_rules.example 123456789012
```