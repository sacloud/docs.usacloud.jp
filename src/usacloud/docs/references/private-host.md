# リファレンス / private-host

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

  === Private-Host-specific options ===

      --class string   (*required: --class or --plan-id) options: [dynamic/ms_windows]
      --plan-id int    (*required: --class or --plan-id)

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
    "Name": "example",
    "Description": "example",
    "Tags": [
        "tag1=example1",
        "tag2=example2"
    ],
    "IconID": 123456789012,
    "Class": "dynamic | ms_windows"
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
    "Name": "example",
    "Description": "example",
    "Tags": [
        "tag1=example1",
        "tag2=example2"
    ],
    "IconID": 123456789012
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

  === Zone options ===

      --zone string   (*required) 

  === Error handling options ===

      --fail-if-not-found   

  === Wait options ===

      --wait-for-release               
      --wait-for-release-timeout int   
      --wait-for-release-tick int      

  === Input options ===

  -y, --assumeyes           Assume that the answer to any question which would be asked is yes
      --generate-skeleton   Output skeleton of parameters with JSON format (aliases: --skeleton)
      --parameters string   Input parameters in JSON format

  === Parameter example ===

      --example   Output example parameters with JSON format

```


