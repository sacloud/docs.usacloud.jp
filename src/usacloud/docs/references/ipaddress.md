# リファレンス / ipaddress

## コマンド一覧

- Basic Commands
    - [list](#list)
    - [read](#read)
- Other Commands
    - [update-host-name](#update-host-name)


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

  === Zone options ===

      --zone string   (*required) 

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
  read ipv4_address [flags]

Aliases:
  read, show

Flags:

  === Ipaddress-specific options ===

      --ipaddress string   (*required) (aliases: --ip-address)

  === Zone options ===

      --zone string   (*required) 

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


## update-host-name {: #update-host-name }

##### Usage
```console
Usage:
  update-host-name { ID | NAME | TAG }... [flags]

Flags:

  === Ipaddress-specific options ===

      --host-name string     (*required) 
      --ip-address string    (*required) 
      --retry-interval int    (default 10)
      --retry-max int         (default 30)

  === Zone options ===

      --zone string   (*required) 

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
    "Zone": "tk1a | tk1b | is1a | is1b | tk1v",
    "IPAddress": "192.0.2.11",
    "HostName": "www.example.com",
    "RetryMax": 30,
    "RetryInterval": 10
}
```


