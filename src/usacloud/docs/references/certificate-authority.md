# リファレンス / certificate-authority

## コマンド一覧

- Basic Commands
    - [list](#list)
    - [create](#create)
    - [read](#read)
    - [update](#update)
    - [delete](#delete)


## list {: #list }

##### Usage
```console
Usage:
  list [flags]

Aliases:
  list, ls, find, select

Flags:

  === Filter options ===

      --names strings   
      --tags strings    

  === Limit/Offset options ===

      --count int   (aliases: --max, --limit)
      --from int    (aliases: --offset)

  === Input options ===

      --generate-skeleton   Output skeleton of parameters with JSON format (aliases: --skeleton)
      --parameters string   Input parameters in JSON format

  === Output options ===

      --format string         Output format in Go templates (aliases: --fmt)
  -o, --output-type string    Output format options: [table/json/yaml] (aliases: --out)
      --query string          Query for JSON output
      --query-driver string   Name of the driver that handles queries to JSON output options: [jmespath/jq]
  -q, --quiet                 Output IDs only

  === Parameter example ===

      --example   Output example parameters with JSON format

```


## create {: #create }

##### Usage
```console
Usage:
  create [flags]

Flags:

  === Common options ===

      --name string          (*required) 
      --description string   
      --tags strings         
      --icon-id int          

  === Certificate-Authority-specific options ===

      --clients string              
      --common-name string          (*required) 
      --country string              (*required) 
      --organization string         (*required) 
      --organization-unit strings   
      --servers string              
      --validity-period-hours int   (*required) 

  === Input options ===

  -y, --assumeyes           Assume that the answer to any question which would be asked is yes
      --generate-skeleton   Output skeleton of parameters with JSON format (aliases: --skeleton)
      --parameters string   Input parameters in JSON format

  === Output options ===

      --format string         Output format in Go templates (aliases: --fmt)
  -o, --output-type string    Output format options: [table/json/yaml] (aliases: --out)
      --query string          Query for JSON output
      --query-driver string   Name of the driver that handles queries to JSON output options: [jmespath/jq]
  -q, --quiet                 Output IDs only

  === Parameter example ===

      --example   Output example parameters with JSON format

```

##### Parameter Examples
```console
{
    "Name": "example",
    "Description": "example",
    "Tags": [
        "tag1=example1",
        "tag2=example2"
    ],
    "IconID": 123456789012,
    "Country": "JP",
    "Organization": "usacloud",
    "OrganizationUnit": [
        "ou1",
        "ou2"
    ],
    "CommonName": "example.usacloud.jp",
    "ValidityPeriodHours": 8760,
    "Clients": [
        {
            "ID": "",
            "Country": "JP",
            "Organization": "usacloud",
            "OrganizationUnit": [
                "ou1",
                "ou2"
            ],
            "CommonName": "client.usacloud.jp",
            "NotAfter": "2023-01-27T08:48:51.39852+09:00",
            "IssuanceMethod": "url | email | csr | public_key",
            "EMail": "example@example.com",
            "CertificateSigningRequest": "-----BEGIN CERTIFICATE REQUEST-----\n...",
            "PublicKey": "-----BEGIN PUBLIC KEY-----\n...",
            "Hold": true
        }
    ],
    "Servers": [
        {
            "ID": "",
            "Country": "JP",
            "Organization": "usacloud",
            "OrganizationUnit": [
                "ou1",
                "ou2"
            ],
            "CommonName": "client.usacloud.jp",
            "NotAfter": "2023-01-27T08:48:51.398521+09:00",
            "SANs": [
                "www1.usacloud.jp",
                "www2.usacloud.jp"
            ],
            "CertificateSigningRequest": "-----BEGIN CERTIFICATE REQUEST-----\n...",
            "PublicKey": "-----BEGIN PUBLIC KEY-----\n...",
            "Hold": true
        }
    ]
}
```


## read {: #read }

##### Usage
```console
Usage:
  read { ID | NAME | TAG } [flags]

Aliases:
  read, show

Flags:

  === Input options ===

      --generate-skeleton   Output skeleton of parameters with JSON format (aliases: --skeleton)
      --parameters string   Input parameters in JSON format

  === Output options ===

      --format string         Output format in Go templates (aliases: --fmt)
  -o, --output-type string    Output format options: [table/json/yaml] (aliases: --out)
      --query string          Query for JSON output
      --query-driver string   Name of the driver that handles queries to JSON output options: [jmespath/jq]
  -q, --quiet                 Output IDs only

  === Parameter example ===

      --example   Output example parameters with JSON format

```


## update {: #update }

##### Usage
```console
Usage:
  update { ID | NAME | TAG }... [flags]

Flags:

  === Common options ===

      --name string          
      --description string   
      --tags strings         
      --icon-id int          

  === Certificate-Authority-specific options ===

      --clients string   
      --servers string   

  === Input options ===

  -y, --assumeyes           Assume that the answer to any question which would be asked is yes
      --generate-skeleton   Output skeleton of parameters with JSON format (aliases: --skeleton)
      --parameters string   Input parameters in JSON format

  === Output options ===

      --format string         Output format in Go templates (aliases: --fmt)
  -o, --output-type string    Output format options: [table/json/yaml] (aliases: --out)
      --query string          Query for JSON output
      --query-driver string   Name of the driver that handles queries to JSON output options: [jmespath/jq]
  -q, --quiet                 Output IDs only

  === Parameter example ===

      --example   Output example parameters with JSON format

```

##### Parameter Examples
```console
{
    "Name": "example",
    "Description": "example",
    "Tags": [
        "tag1=example1",
        "tag2=example2"
    ],
    "IconID": 123456789012,
    "Clients": [
        {
            "ID": "",
            "Country": "JP",
            "Organization": "usacloud",
            "OrganizationUnit": [
                "ou1",
                "ou2"
            ],
            "CommonName": "client.usacloud.jp",
            "NotAfter": "2023-01-27T08:48:51.399064+09:00",
            "IssuanceMethod": "url | email | csr | public_key",
            "EMail": "example@example.com",
            "CertificateSigningRequest": "-----BEGIN CERTIFICATE REQUEST-----\n...",
            "PublicKey": "-----BEGIN PUBLIC KEY-----\n...",
            "Hold": true
        }
    ],
    "Servers": [
        {
            "ID": "",
            "Country": "JP",
            "Organization": "usacloud",
            "OrganizationUnit": [
                "ou1",
                "ou2"
            ],
            "CommonName": "client.usacloud.jp",
            "NotAfter": "2023-01-27T08:48:51.399065+09:00",
            "SANs": [
                "www1.usacloud.jp",
                "www2.usacloud.jp"
            ],
            "CertificateSigningRequest": "-----BEGIN CERTIFICATE REQUEST-----\n...",
            "PublicKey": "-----BEGIN PUBLIC KEY-----\n...",
            "Hold": true
        }
    ]
}
```


## delete {: #delete }

##### Usage
```console
Usage:
  delete { ID | NAME | TAG }... [flags]

Aliases:
  delete, rm

Flags:

  === Error handling options ===

      --fail-if-not-found   

  === Input options ===

  -y, --assumeyes           Assume that the answer to any question which would be asked is yes
      --generate-skeleton   Output skeleton of parameters with JSON format (aliases: --skeleton)
      --parameters string   Input parameters in JSON format

  === Output options ===

      --format string         Output format in Go templates (aliases: --fmt)
  -o, --output-type string    Output format options: [table/json/yaml] (aliases: --out)
      --query string          Query for JSON output
      --query-driver string   Name of the driver that handles queries to JSON output options: [jmespath/jq]
  -q, --quiet                 Output IDs only

  === Parameter example ===

      --example   Output example parameters with JSON format

```


