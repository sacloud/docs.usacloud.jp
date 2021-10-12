# マネージドPKI: sakuracloud_certificate_authority

## Example Usage

```tf
terraform {
  required_providers {
    tls = {
      source  = "hashicorp/tls"
      version = "3.1.0"
    }
    sakuracloud = {
      source  = "sacloud/sakuracloud"
      version = "2.14.0"
    }
  }
}

resource "tls_private_key" "client_key" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P384"
}

resource "tls_cert_request" "client_csr" {
  key_algorithm   = "ECDSA"
  private_key_pem = tls_private_key.client_key.private_key_pem

  subject {
    common_name  = "client-csr.usacloud.com"
    organization = "usacloud"
  }
}

resource "tls_private_key" "server_key" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P384"
}

resource "tls_cert_request" "server_csr" {
  key_algorithm   = "ECDSA"
  private_key_pem = tls_private_key.server_key.private_key_pem

  subject {
    common_name  = "server-csr.usacloud.com"
    organization = "usacloud"
  }
}

resource "sakuracloud_certificate_authority" "foobar" {
  name = "foobar"

  validity_period_hours = 24 * 3650

  subject {
    common_name        = "pki.usacloud.jp"
    country            = "JP"
    organization       = "usacloud"
    organization_units = ["ou1", "ou2"]
  }

  # by public_key
  client {
    subject {
      common_name        = "client1.usacloud.jp"
      country            = "JP"
      organization       = "usacloud"
      organization_units = ["ou1", "ou2"]
    }
    validity_period_hours = 24 * 3650
    public_key            = tls_private_key.client_key.public_key_pem
  }

  // by CSR
  client {
    subject {
      common_name        = "client2.usacloud.jp"
      country            = "JP"
      organization       = "usacloud"
      organization_units = ["ou1", "ou2"]
    }
    validity_period_hours = 24 * 3650
    csr                   = tls_cert_request.client_csr.cert_request_pem
  }

  # by email
  client {
    subject {
      common_name        = "client3.usacloud.jp"
      country            = "JP"
      organization       = "usacloud"
      organization_units = ["ou1", "ou2"]
    }
    validity_period_hours = 24 * 3650
    email                 = "example@example.com"
  }

  # by URL
  client {
    subject {
      common_name        = "client4.usacloud.jp"
      country            = "JP"
      organization       = "usacloud"
      organization_units = ["ou1", "ou2"]
    }
    validity_period_hours = 24 * 3650
  }

  # by public key
  server {
    subject {
      common_name        = "server1.usacloud.jp"
      country            = "JP"
      organization       = "usacloud"
      organization_units = ["ou1", "ou2"]
    }

    subject_alternative_names = ["alt1.usacloud.jp", "alt2.usacloud.jp"]

    validity_period_hours = 24 * 3650
    public_key            = tls_private_key.server_key.public_key_pem
  }

  # by CSR
  server {
    subject {
      common_name        = "server2.usacloud.jp"
      country            = "JP"
      organization       = "usacloud"
      organization_units = ["ou1", "ou2"]
    }

    subject_alternative_names = ["alt1.usacloud.jp", "alt2.usacloud.jp"]

    validity_period_hours = 24 * 3650
    csr                   = tls_cert_request.server_csr.cert_request_pem
  }
}


```

<div class="editor">

<h2><a href="https://zouen-alpha.usacloud.jp/#resource/certificate_authority" target="_blank" rel="noopener noreferrer">Code Editor</a></h2>

<iframe src="https://zouen-alpha.usacloud.jp/#resource/certificate_authority"></iframe>

</div>


## Argument Reference

* `name` - (Required) 名前 / `1`-`64`文字で指定
* `client` - (Optional) クライアント証明書のリスト。詳細は[clientブロック](#client)を参照
* `server` - (Optional) サーバ証明書のリスト。詳細は[serverブロック](#server)を参照
* `subject` - (Required) CAのサブジェクト。詳細は[subjectブロック](#subject)を参照
* `validity_period_hours` - (Required) 証明書の有効期限時間数

##### clientブロック

* `csr` - (Optional) CSR
* `email` - (Optional) Eメールアドレス
* `hold` - (Optional) 一時停止フラグ
* `public_key` - (Optional) 公開鍵
* `subject` - (Required) サブジェクト。詳細は[subjectブロック](#subject)を参照
* `validity_period_hours` - (Required) 証明書の有効期限時間数

##### serverブロック

* `csr` - (Optional) CSR
* `hold` - (Optional) 一時停止フラグ
* `public_key` - (Optional) 公開鍵
* `subject` - (Required) サブジェクト。詳細は[subjectブロック](#subject)を参照
* `subject_alternative_names` - (Optional) SANs
* `validity_period_hours` - (Required) 証明書の有効期限時間数

##### subjectブロック

* `common_name` - (Required) コモンネーム
* `country` - (Required) 国コード
* `organization` - (Required 組織名
* `organization_units` - (Optional) OU

#### Common Arguments

* `description` - (Optional) 説明 / `1`-`512`文字で指定
* `icon_id` - (Optional) アイコンID
* `tags` - (Optional) タグ

### Timeouts

`timeouts`ブロックで[カスタムタイムアウト](https://www.terraform.io/docs/configuration/resources.html#operation-timeouts)が設定可能です。

* `create` - 作成 (デフォルト: 5分)
* `update` - 更新 (デフォルト: 5分)
* `delete` - 削除 (デフォルト: 5分)


## Attribute Reference

* `id` - ID
* `certificate` - CA証明書データ(PEM format)
* `crl_url` - CRLのURL
* `not_after` - CA証明書の有効期間終了(RFC3339 format)
* `not_before` - CA証明書の有効期間開始(RFC3339 format)
* `serial_number` - CAのシリアルナンバー

`client`の各要素は以下の項目も参照可能です。

* `certificate` - 証明書データ(PEM format)
* `id` - ID
* `issue_state` - 発行状態
* `not_after` - 証明書の有効期間終了(RFC3339 format)
* `not_before` - 証明書の有効期間開始(RFC3339 format)
* `serial_number` - シリアルナンバー
* `url` - 証明書の発行用URL、発行方法がURLの場合のみ有効

`server`の各要素は以下の項目も参照可能です。

* `certificate` - 証明書データ(PEM format)
* `id` - ID
* `issue_state` - 発行状態
* `not_after` - 証明書の有効期間終了(RFC3339 format)
* `not_before` - 証明書の有効期間開始(RFC3339 format)
* `serial_number` - シリアルナンバー