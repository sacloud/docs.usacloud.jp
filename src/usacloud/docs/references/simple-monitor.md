# リファレンス / simple-monitor

## コマンド一覧

- Basic Commands
    - [list](#list)
    - [create](#create)
    - [read](#read)
    - [update](#update)
    - [delete](#delete)
- Monitoring Commands
    - [health](#health)
    - [monitor-response-time](#monitor-response-time)


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

      --description string   
      --tags strings         
      --icon-id int          

  === Simple-Monitor-specific options ===

      --delay-loop int                             (default 60)
      --enabled                                    (default true)
      --health-check-basic-auth-password string   
      --health-check-basic-auth-username string   
      --health-check-community string             
      --health-check-contains-string string       
      --health-check-expected-data string         
      --health-check-host string                  
      --health-check-http2                        
      --health-check-oid string                   
      --health-check-path string                  
      --health-check-port int                     
      --health-check-protocol string              (*required) options: [http/https/ping/tcp/dns/ssh/smtp/pop3/snmp/sslcertificate]
      --health-check-q-name string                
      --health-check-remaining-days int           
      --health-check-sni                          
      --health-check-snmp-version string          
      --health-check-status int                   
      --notify-email-enabled                      
      --notify-email-html                         
      --notify-interval int                        (default 7200)
      --notify-slack-enabled                      
      --slack-webhooks-url string                 
      --target string                             (*required) 
      --timeout int                               

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
    "Target": "www.example.com",
    "Description": "example",
    "Tags": [
        "tag1=example1",
        "tag2=example2"
    ],
    "IconID": 123456789012,
    "DelayLoop": 60,
    "Timeout": 10,
    "Enabled": true,
    "HealthCheck": {
        "Protocol": "http | https | ping | tcp | dns | ssh | smtp | pop3 | snmp | sslcertificate",
        "Port": 80,
        "Path": "/healthz",
        "Status": 200,
        "ContainsString": "ok",
        "SNI": true,
        "Host": "www2.example.com",
        "BasicAuthUsername": "username",
        "BasicAuthPassword": "password",
        "HTTP2": true
    },
    "NotifyEmailEnabled": true,
    "NotifyEmailHTML": true,
    "NotifySlackEnabled": true,
    "SlackWebhooksURL": "https://hooks.slack.com/services/XXXXXXXXX/XXXXXXXXX/XXXXXXXXXXXXXXXXXXXXXXXX",
    "NotifyInterval": 7200
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

      --description string   
      --tags strings         
      --icon-id int          

  === Simple-Monitor-specific options ===

      --delay-loop int                            
      --enabled                                   
      --health-check-basic-auth-password string   
      --health-check-basic-auth-username string   
      --health-check-community string             
      --health-check-contains-string string       
      --health-check-expected-data string         
      --health-check-host string                  
      --health-check-http2                        
      --health-check-oid string                   
      --health-check-path string                  
      --health-check-port int                     
      --health-check-protocol string              options: [http/https/ping/tcp/dns/ssh/smtp/pop3/snmp/sslcertificate]
      --health-check-q-name string                
      --health-check-remaining-days int           
      --health-check-sni                          
      --health-check-snmp-version string          
      --health-check-status int                   
      --notify-email-enabled                      
      --notify-email-html                         
      --notify-interval int                       
      --notify-slack-enabled                      
      --slack-webhooks-url string                 
      --timeout int                               

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
    "Description": "example",
    "Tags": [
        "tag1=example1",
        "tag2=example2"
    ],
    "IconID": 123456789012,
    "DelayLoop": 60,
    "Timeout": 10,
    "Enabled": true,
    "HealthCheck": {
        "Protocol": "http | https | ping | tcp | dns | ssh | smtp | pop3 | snmp | sslcertificate",
        "Port": 80,
        "Path": "/healthz",
        "Status": 200,
        "ContainsString": "ok",
        "SNI": true,
        "Host": "www2.example.com",
        "BasicAuthUsername": "username",
        "BasicAuthPassword": "password",
        "HTTP2": true
    },
    "NotifyEmailEnabled": true,
    "NotifyEmailHTML": true,
    "NotifySlackEnabled": true,
    "SlackWebhooksURL": "https://hooks.slack.com/services/XXXXXXXXX/XXXXXXXXX/XXXXXXXXXXXXXXXXXXXXXXXX",
    "NotifyInterval": 7200
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


## health {: #health }

##### Usage
```console
Usage:
  health { ID | NAME | TAG }... [flags]

Flags:

  === Monitor options ===

      --end string     
      --start string   

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


## monitor-response-time {: #monitor-response-time }

##### Usage
```console
Usage:
  monitor-response-time { ID | NAME | TAG }... [flags]

Aliases:
  monitor-response-time, monitor

Flags:

  === Monitor options ===

      --end string     
      --start string   

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


