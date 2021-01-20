# リファレンス / mobile-gateway

## コマンド一覧

- Basic Commands
    - [list](#list)
    - [create](#create)
    - [read](#read)
    - [update](#update)
    - [delete](#delete)
- Power Management Commands
    - [boot](#boot)
    - [shutdown](#shutdown)
    - [reset](#reset)
- Monitoring Commands
    - [monitor-interface](#monitor-interface)
    - [logs](#logs)
- Other Commands
    - [wait-until-ready](#wait-until-ready)
    - [wait-until-shutdown](#wait-until-shutdown)


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

  === Mobile-Gateway-specific options ===

      --boot-after-create                                 
      --dns1 string                                       
      --dns2 string                                       
      --inter-device-communication-enabled                
      --internet-connection-enabled                       
      --sim-routes string                                 
      --sims string                                       
      --static-routes string                              
      --traffic-config-auto-traffic-shaping               
      --traffic-config-band-width-limit-in-kbps int       
      --traffic-config-email-notify-enabled               
      --traffic-config-slack-notify-enabled               
      --traffic-config-slack-notify-webhooks-url string   
      --traffic-config-traffic-quota-in-mb int            

  === Network options ===

      --private-interface-ip-address string      (*required) 
      --private-interface-network-mask-len int   
      --private-interface-switch-id int          

  === Zone options ===

      --zone string   (*required) 

  === Wait options ===

      --no-wait   

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
    "InternetConnectionEnabled": true,
    "InterDeviceCommunicationEnabled": true,
    "SIMs": [
        {
            "SIMID": 123456789012,
            "IPAddress": "192.0.2.11"
        }
    ],
    "SIMRoutes": [
        {
            "SIMID": 123456789012,
            "Prefix": "192.0.2.0/24"
        }
    ],
    "StaticRoutes": [
        {
            "Prefix": "192.0.2.0/24",
            "NextHop": "192.0.2.2"
        }
    ],
    "PrivateInterface": {
        "SwitchID": 123456789012,
        "IPAddress": "192.0.2.11",
        "NetworkMaskLen": 24
    },
    "DNS": {
        "DNS1": "133.242.0.3 | 210.188.224.10 | n.n.n.n",
        "DNS2": "133.242.0.4 | 210.188.224.11 | n.n.n.n"
    },
    "TrafficConfig": {
        "TrafficQuotaInMB": 10,
        "BandWidthLimitInKbps": 128,
        "EmailNotifyEnabled": true,
        "SlackNotifyEnabled": true,
        "SlackNotifyWebhooksURL": "https://hooks.slack.com/services/XXXXXXXXX/XXXXXXXXX/XXXXXXXXXXXXXXXXXXXXXXXX",
        "AutoTrafficShaping": true
    },
    "NoWait": false,
    "BootAfterCreate": true
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

  === Mobile-Gateway-specific options ===

      --dns1 string                                       
      --dns2 string                                       
      --inter-device-communication-enabled                
      --internet-connection-enabled                       
      --sim-routes string                                 
      --sims string                                       
      --static-routes string                              
      --traffic-config-auto-traffic-shaping               
      --traffic-config-band-width-limit-in-kbps int       
      --traffic-config-email-notify-enabled               
      --traffic-config-slack-notify-enabled               
      --traffic-config-slack-notify-webhooks-url string   
      --traffic-config-traffic-quota-in-mb int            

  === Network options ===

      --private-interface-ip-address string      
      --private-interface-network-mask-len int   
      --private-interface-switch-id int          

  === Zone options ===

      --zone string   (*required) 

  === Wait options ===

      --no-wait   

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
    "PrivateInterface": {
        "SwitchID": 123456789012,
        "IPAddress": "192.0.2.11",
        "NetworkMaskLen": 24
    },
    "InternetConnectionEnabled": true,
    "InterDeviceCommunicationEnabled": true,
    "SIMs": [
        {
            "SIMID": 123456789012,
            "IPAddress": "192.0.2.11"
        }
    ],
    "SIMRoutes": [
        {
            "SIMID": 123456789012,
            "Prefix": "192.0.2.0/24"
        }
    ],
    "StaticRoutes": [
        {
            "Prefix": "192.0.2.0/24",
            "NextHop": "192.0.2.2"
        }
    ],
    "DNS": {
        "DNS1": "133.242.0.3 | 210.188.224.10 | n.n.n.n",
        "DNS2": "133.242.0.4 | 210.188.224.11 | n.n.n.n"
    },
    "TrafficConfig": {
        "TrafficQuotaInMB": 10,
        "BandWidthLimitInKbps": 128,
        "EmailNotifyEnabled": true,
        "SlackNotifyEnabled": true,
        "SlackNotifyWebhooksURL": "https://hooks.slack.com/services/XXXXXXXXX/XXXXXXXXX/XXXXXXXXXXXXXXXXXXXXXXXX",
        "AutoTrafficShaping": true
    },
    "NoWait": false
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

  === Delete options ===

  -f, --force   

  === Zone options ===

      --zone string   (*required) 

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


## boot {: #boot }

##### Usage
```console
Usage:
  boot { ID | NAME | TAG }... [flags]

Aliases:
  boot, power-on

Flags:

  === Zone options ===

      --zone string   (*required) 

  === Wait options ===

      --no-wait   

  === Input options ===

  -y, --assumeyes           Assume that the answer to any question which would be asked is yes
      --generate-skeleton   Output skeleton of parameters with JSON format (aliases: --skeleton)
      --parameters string   Input parameters in JSON format

  === Parameter example ===

      --example   Output example parameters with JSON format

```


## shutdown {: #shutdown }

##### Usage
```console
Usage:
  shutdown { ID | NAME | TAG }... [flags]

Aliases:
  shutdown, power-off

Flags:

  === Mobile-Gateway-specific options ===

  -f, --force-shutdown   (aliases: --force)

  === Zone options ===

      --zone string   (*required) 

  === Wait options ===

      --no-wait   

  === Input options ===

  -y, --assumeyes           Assume that the answer to any question which would be asked is yes
      --generate-skeleton   Output skeleton of parameters with JSON format (aliases: --skeleton)
      --parameters string   Input parameters in JSON format

  === Parameter example ===

      --example   Output example parameters with JSON format

```


## reset {: #reset }

##### Usage
```console
Usage:
  reset { ID | NAME | TAG }... [flags]

Flags:

  === Zone options ===

      --zone string   (*required) 

  === Input options ===

  -y, --assumeyes           Assume that the answer to any question which would be asked is yes
      --generate-skeleton   Output skeleton of parameters with JSON format (aliases: --skeleton)
      --parameters string   Input parameters in JSON format

  === Parameter example ===

      --example   Output example parameters with JSON format

```


## monitor-interface {: #monitor-interface }

##### Usage
```console
Usage:
  monitor-interface { ID | NAME | TAG }... [flags]

Aliases:
  monitor-interface, monitor-nic

Flags:

  === Monitor options ===

      --end string     
      --start string   

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


## logs {: #logs }

##### Usage
```console
Usage:
  logs { ID | NAME | TAG }... [flags]

Flags:

  === Monitor options ===

      --end string     
      --start string   

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


## wait-until-ready {: #wait-until-ready }

##### Usage
```console
Usage:
  wait-until-ready { ID | NAME | TAG }... [flags]

Aliases:
  wait-until-ready, wait-for-boot

Flags:

  === Zone options ===

      --zone string   (*required) 

  === Input options ===

      --generate-skeleton   Output skeleton of parameters with JSON format (aliases: --skeleton)
      --parameters string   Input parameters in JSON format

  === Parameter example ===

      --example   Output example parameters with JSON format

```


## wait-until-shutdown {: #wait-until-shutdown }

##### Usage
```console
Usage:
  wait-until-shutdown { ID | NAME | TAG }... [flags]

Aliases:
  wait-until-shutdown, wait-for-down

Flags:

  === Zone options ===

      --zone string   (*required) 

  === Input options ===

      --generate-skeleton   Output skeleton of parameters with JSON format (aliases: --skeleton)
      --parameters string   Input parameters in JSON format

  === Parameter example ===

      --example   Output example parameters with JSON format

```


