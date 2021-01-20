# リファレンス / web-accelerator

## コマンド一覧

- Basic Commands
    - [list](#list)
    - [read](#read)
- Certificate Management Commands
    - [read-certificate](#read-certificate)
    - [create-certificate](#create-certificate)
    - [update-certificate](#update-certificate)
- Cache Management Commands
    - [delete-cache](#delete-cache)
    - [delete-cache-all](#delete-cache-all)


## list {: #list }

##### Usage
```console
Usage:
  list [flags]

Aliases:
  list, ls, find, select

Flags:

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


## read-certificate {: #read-certificate }

##### Usage
```console
Usage:
  read-certificate { ID | NAME | TAG } [flags]

Aliases:
  read-certificate, certificate-read, cert-read

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


## create-certificate {: #create-certificate }

##### Usage
```console
Usage:
  create-certificate { ID | NAME | TAG } [flags]

Aliases:
  create-certificate, certificate-create, cert-create

Flags:

  === Web-Accelerator-specific options ===

      --certificate-chain string   (*required) 
      --key string                 (*required) 

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
    "CertificateChain": "/path/to/your/certificate/chain | -----BEGIN CERTIFICATE-----\n...",
    "Key": "/path/to/your/private-key | -----BEGIN RSA PRIVATE KEY-----\n..."
}
```


## update-certificate {: #update-certificate }

##### Usage
```console
Usage:
  update-certificate { ID | NAME | TAG } [flags]

Aliases:
  update-certificate, certificate-update, cert-update

Flags:

  === Web-Accelerator-specific options ===

      --certificate-chain string   (*required) 
      --key string                 

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
    "CertificateChain": "/path/to/your/certificate/chain | -----BEGIN CERTIFICATE-----\n...",
    "Key": "/path/to/your/private-key | -----BEGIN RSA PRIVATE KEY-----\n..."
}
```


## delete-cache {: #delete-cache }

##### Usage
```console
Usage:
  delete-cache [flags]

Aliases:
  delete-cache, cache-delete

Flags:

  === Web-Accelerator-specific options ===

      --url strings   (*required) 

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


## delete-cache-all {: #delete-cache-all }

##### Usage
```console
Usage:
  delete-cache-all [flags]

Aliases:
  delete-cache-all, cache-delete-all

Flags:

  === Web-Accelerator-specific options ===

      --domain string   (*required) 

  === Input options ===

  -y, --assumeyes           Assume that the answer to any question which would be asked is yes
      --generate-skeleton   Output skeleton of parameters with JSON format (aliases: --skeleton)
      --parameters string   Input parameters in JSON format

  === Parameter example ===

      --example   Output example parameters with JSON format

```


