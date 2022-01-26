# リファレンス / disk

## コマンド一覧

- Basic Commands
    - [list](#list)
    - [create](#create)
    - [read](#read)
    - [update](#update)
    - [delete](#delete)
- Operation Commands
    - [connect-to-server](#connect-to-server)
    - [edit](#edit)
    - [disconnect-from-server](#disconnect-from-server)
    - [resize-partition](#resize-partition)
- Monitoring Commands
    - [monitor-disk](#monitor-disk)
- Other Commands
    - [wait-until-ready](#wait-until-ready)


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

  === Plan options ===

      --disk-plan string   (*required) options: [ssd/hdd] (default "ssd")
      --size int            (default 20)
      --connector string   (*required) options: [virtio/ide] (aliases: --connection) (default "virtio")

  === Disk-specific options ===

      --distant-from int   
      --server-id int      

  === Edit disk options ===

      --edit-disk-host-name string          
      --edit-disk-password string           
      --edit-disk-ip-address string         
      --edit-disk-netmask int               (aliases: --network-mask-len)
      --edit-disk-gateway string            (aliases: --default-route)
      --edit-disk-disable-pw-auth           
      --edit-disk-enable-dhcp               
      --edit-disk-change-partition-uuid     
      --edit-disk-ssh-keys strings          
      --edit-disk-ssh-key-ids int           
      --edit-disk-make-ssh-keys-ephemeral   
      --edit-disk-note-ids int              
      --edit-disk-notes string              
      --edit-disk-make-notes-ephemeral      

  === Source options ===

      --os-type string          options: [almalinux/rockylinux/miraclelinux/centos8stream/ubuntu/debian/rancheros/k3os/...]
      --source-disk-id int      
      --source-archive-id int   

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
    "DiskPlan": "ssd | hdd",
    "SizeGB": 20,
    "Connection": "virtio | ide",
    "OSType": "centos | centos8stream | centos7 | almalinux | rockylinux | miracle | miraclelinux | ubuntu | ubuntu2004 | ubuntu1804 | debian | debian10 | debian11 | rancheros | k3os | kusanagi | windows2016 | windows2016-rds | windows2016-rds-office | windows2016-sql-web | windows2016-sql-standard | windows2016-sql-standard-all | windows2016-sql2017-standard | windows2016-sql2017-enterprise | windows2016-sql2017-standard-all | windows2019 | windows2019-rds | windows2019-rds-office2019 | windows2019-sql2017-web | windows2019-sql2019-web | windows2019-sql2017-standard | windows2019-sql2019-standard | windows2019-sql2017-enterprise | windows2019-sql2019-enterprise | windows2019-sql2017-standard-all | windows2019-sql2019-standard-all",
    "SourceDiskID": 123456789012,
    "SourceArchiveID": 123456789012,
    "ServerID": 123456789012,
    "DistantFrom": [
        123456789012
    ],
    "EditDisk": {
        "HostName": "hostname",
        "Password": "password",
        "IPAddress": "192.0.2.11",
        "NetworkMaskLen": 24,
        "DefaultRoute": "192.0.2.1",
        "DisablePWAuth": true,
        "EnableDHCP": true,
        "ChangePartitionUUID": true,
        "SSHKeys": [
            "/path/to/your/public/key",
            "ssh-rsa ..."
        ],
        "SSHKeyIDs": [
            123456789012
        ],
        "IsSSHKeysEphemeral": true,
        "NoteIDs": [
            123456789012
        ],
        "IsNotesEphemeral": true,
        "Notes": [
            {
                "ID": 123456789012,
                "Variables": {
                    "variable1": "foo",
                    "variable2": "bar"
                }
            }
        ]
    },
    "NoWait": false
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

  === Plan options ===

      --connector string   options: [virtio/ide] (aliases: --connection)

  === Edit disk options ===

      --edit-disk-host-name string          
      --edit-disk-password string           
      --edit-disk-ip-address string         
      --edit-disk-netmask int               (aliases: --network-mask-len)
      --edit-disk-gateway string            (aliases: --default-route)
      --edit-disk-disable-pw-auth           
      --edit-disk-enable-dhcp               
      --edit-disk-change-partition-uuid     
      --edit-disk-ssh-keys strings          
      --edit-disk-ssh-key-ids int           
      --edit-disk-make-ssh-keys-ephemeral   
      --edit-disk-note-ids int              
      --edit-disk-notes string              
      --edit-disk-make-notes-ephemeral      

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
    "Connection": "virtio | ide",
    "EditDisk": {
        "HostName": "hostname",
        "Password": "password",
        "IPAddress": "192.0.2.11",
        "NetworkMaskLen": 24,
        "DefaultRoute": "192.0.2.1",
        "DisablePWAuth": true,
        "EnableDHCP": true,
        "ChangePartitionUUID": true,
        "SSHKeys": [
            "/path/to/your/public/key",
            "ssh-rsa ..."
        ],
        "SSHKeyIDs": [
            123456789012
        ],
        "IsSSHKeysEphemeral": true,
        "NoteIDs": [
            123456789012
        ],
        "IsNotesEphemeral": true,
        "Notes": [
            {
                "ID": 123456789012,
                "Variables": {
                    "variable1": "foo",
                    "variable2": "bar"
                }
            }
        ]
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

  === Output options ===

      --format string         Output format in Go templates (aliases: --fmt)
  -o, --output-type string    Output format options: [table/json/yaml] (aliases: --out)
      --query string          Query for JSON output
      --query-driver string   Name of the driver that handles queries to JSON output options: [jmespath/jq]
  -q, --quiet                 Output IDs only

  === Parameter example ===

      --example   Output example parameters with JSON format

```


## connect-to-server {: #connect-to-server }

##### Usage
```console
Usage:
  connect-to-server { ID | NAME | TAG } [flags]

Aliases:
  connect-to-server, server-connect

Flags:

  === Disk-specific options ===

      --server-id int   (*required) 

  === Zone options ===

      --zone string   (*required) 

  === Input options ===

  -y, --assumeyes           Assume that the answer to any question which would be asked is yes
      --generate-skeleton   Output skeleton of parameters with JSON format (aliases: --skeleton)
      --parameters string   Input parameters in JSON format

  === Parameter example ===

      --example   Output example parameters with JSON format

```


## edit {: #edit }

##### Usage
```console
Usage:
  edit { ID | NAME | TAG }... [flags]

Flags:

  === Edit disk options ===

      --host-name string          
      --password string           
      --ip-address string         
      --netmask int               (aliases: --network-mask-len)
      --gateway string            (aliases: --default-route)
      --disable-pw-auth           
      --enable-dhcp               
      --change-partition-uuid     
      --ssh-keys strings          
      --ssh-key-ids int           
      --make-ssh-keys-ephemeral   
      --note-ids int              
      --notes string              
      --make-notes-ephemeral      

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


## disconnect-from-server {: #disconnect-from-server }

##### Usage
```console
Usage:
  disconnect-from-server { ID | NAME | TAG } [flags]

Aliases:
  disconnect-from-server, server-disconnect

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


## resize-partition {: #resize-partition }

##### Usage
```console
Usage:
  resize-partition { ID | NAME | TAG } [flags]

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


## monitor-disk {: #monitor-disk }

##### Usage
```console
Usage:
  monitor-disk { ID | NAME | TAG }... [flags]

Aliases:
  monitor-disk, monitor

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
  wait-until-ready, wait, wait-for-copy

Flags:

  === Zone options ===

      --zone string   (*required) 

  === Input options ===

      --generate-skeleton   Output skeleton of parameters with JSON format (aliases: --skeleton)
      --parameters string   Input parameters in JSON format

  === Parameter example ===

      --example   Output example parameters with JSON format

```


