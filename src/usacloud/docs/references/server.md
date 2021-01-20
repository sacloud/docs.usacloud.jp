# リファレンス / server

## コマンド一覧

- Basic Commands
    - [list](#list)
    - [create](#create)
    - [read](#read)
    - [update](#update)
    - [delete](#delete)
- Connect Commands
    - [ssh](#ssh)
    - [vnc](#vnc)
    - [rdp](#rdp)
- Power Management Commands
    - [boot](#boot)
    - [shutdown](#shutdown)
    - [reset](#reset)
- Monitoring Commands
    - [monitor-cpu](#monitor-cpu)
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

Aliases:
  create, build

Flags:

  === Common options ===

      --disk-name string          
      --name string               (*required) 
      --description string        
      --disk-description string   
      --disk-tags strings         
      --tags strings              
      --disk-icon-id int          
      --icon-id int               

  === Plan options ===

      --cpu int             (*required) (aliases: --core) (default 1)
      --memory int          (*required)  (default 1)
      --commitment string   (*required) options: [standard/dedicatedcpu] (default "standard")
      --generation string   (*required) options: [default/g100/g200] (default "default")

  === Server-specific options ===

      --boot-after-create         
      --cdrom-id int              (aliases: --iso-image-id)
      --interface-driver string   (*required) options: [virtio/e1000] (default "virtio")
      --private-host-id int       

  === Disk options ===

      --disk-connection string       options: [virtio/ide]
      --disk-disk-plan string        options: [ssd/hdd]
      --disk-distant-from int        
      --disk-id int                  
      --disk-no-wait                 
      --disk-os-type string          options: [centos/centos8stream/centos8/ubuntu/ubuntu2004/debian/debian10/coreos/rancheros/k3os/freebsd/...]
      --disk-size int                (aliases: --size-gb)
      --disk-source-archive-id int   
      --disk-source-disk-id int      
      --disk-ids int                 
      --disks string                 

  === Edit disk options ===

      --disk-edit-host-name string          
      --disk-edit-password string           
      --disk-edit-ip-address string         
      --disk-edit-netmask int               (aliases: --network-mask-len)
      --disk-edit-gateway string            (aliases: --default-route)
      --disk-edit-disable-pw-auth           
      --disk-edit-enable-dhcp               
      --disk-edit-change-partition-uuid     
      --disk-edit-ssh-keys strings          
      --disk-edit-ssh-key-ids int           
      --disk-edit-make-ssh-keys-ephemeral   
      --disk-edit-note-ids int              
      --disk-edit-notes string              
      --disk-edit-make-notes-ephemeral      

  === Network options ===

      --network-interface-packet-filter-id int     
      --network-interface-upstream string          options: [shared/disconnected/(switch-id)]
      --network-interface-user-ip-address string   
      --network-interfaces string                  

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
    "CPU": 1,
    "Memory": 2,
    "Commitment": "standard | dedicatedcpu",
    "Generation": "default | g100 | g200",
    "InterfaceDriver": "virtio | e1000",
    "BootAfterCreate": true,
    "CDROMID": 123456789012,
    "PrivateHostID": 123456789012,
    "NetworkInterfaces": [
        {
            "Upstream": "shared | disconnected | (switch-id)",
            "PacketFilterID": 123456789012,
            "UserIPAddress": "192.0.2.11"
        }
    ],
    "Disks": [
        {
            "Description": "新規ディスクを作成する例",
            "Tags": [
                "tag1=example1",
                "tag2=example2"
            ],
            "IconID": 123456789012,
            "DiskPlan": "ssd | hdd",
            "Connection": "virtio | ide",
            "SourceDiskID": 123456789012,
            "SourceArchiveID": 123456789012,
            "SizeGB": 20,
            "DistantFrom": [
                123456789012
            ],
            "OSType": "centos | centos8stream | centos8 | centos7 | ubuntu | ubuntu2004 | ubuntu1804 | ubuntu1604 | debian | debian10 | debian9 | coreos | rancheros | k3os | kusanagi | freebsd | windows2016 | windows2016-rds | windows2016-rds-office | windows2016-sql-web | windows2016-sql-standard | windows2016-sql-standard-all | windows2016-sql2017-standard | windows2016-sql2017-enterprise | windows2016-sql2017-standard-all | windows2019 | windows2019-rds | windows2019-rds-office2019 | windows2019-sql2017-web | windows2019-sql2019-web | windows2019-sql2017-standard | windows2019-sql2019-standard | windows2019-sql2017-enterprise | windows2019-sql2019-enterprise | windows2019-sql2017-standard-all | windows2019-sql2019-standard-all",
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
            "NoWait": true
        },
        {
            "ID": 123456789012,
            "Description": "既存のディスクを接続する例",
            "EditDisk": {},
            "NoWait": false
        }
    ],
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

      --cpu int             (aliases: --core)
      --memory int          
      --commitment string   options: [standard/dedicatedcpu]
      --generation string   options: [default/g100/g200]

  === Server-specific options ===

      --cdrom-id int                (aliases: --iso-image-id)
      --disks string                
      --force-shutdown              
      --interface-driver string     options: [interface_dirver]
      --network-interfaces string   
      --private-host-id int         

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
    "CPU": 1,
    "Memory": 2,
    "Commitment": "standard | dedicatedcpu",
    "Generation": "default | g100 | g200",
    "InterfaceDriver": "virtio | e1000",
    "CDROMID": 123456789012,
    "PrivateHostID": 123456789012,
    "NetworkInterfaces": [
        {
            "Upstream": "shared | disconnected | (switch-id)",
            "PacketFilterID": 123456789012,
            "UserIPAddress": "192.0.2.11"
        }
    ],
    "Disks": [
        {
            "Description": "新規ディスクを作成する例",
            "Tags": [
                "tag1=example1",
                "tag2=example2"
            ],
            "IconID": 123456789012,
            "DiskPlan": "ssd | hdd",
            "Connection": "virtio | ide",
            "SourceDiskID": 123456789012,
            "SourceArchiveID": 123456789012,
            "SizeGB": 20,
            "DistantFrom": [
                123456789012
            ],
            "OSType": "centos | centos8stream | centos8 | centos7 | ubuntu | ubuntu2004 | ubuntu1804 | ubuntu1604 | debian | debian10 | debian9 | coreos | rancheros | k3os | kusanagi | freebsd | windows2016 | windows2016-rds | windows2016-rds-office | windows2016-sql-web | windows2016-sql-standard | windows2016-sql-standard-all | windows2016-sql2017-standard | windows2016-sql2017-enterprise | windows2016-sql2017-standard-all | windows2019 | windows2019-rds | windows2019-rds-office2019 | windows2019-sql2017-web | windows2019-sql2019-web | windows2019-sql2017-standard | windows2019-sql2019-standard | windows2019-sql2017-enterprise | windows2019-sql2019-enterprise | windows2019-sql2017-standard-all | windows2019-sql2019-standard-all",
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
            "NoWait": true
        },
        {
            "ID": 123456789012,
            "Description": "既存のディスクを接続する例",
            "EditDisk": {},
            "NoWait": false
        }
    ],
    "NoWait": false,
    "ForceShutdown": false
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
      --with-disks   

  === Zone options ===

      --zone string   (*required) 

  === Error handling options ===

      --fail-if-not-found   

  === Input options ===

  -y, --assumeyes           Assume that the answer to any question which would be asked is yes
      --generate-skeleton   Output skeleton of parameters with JSON format (aliases: --skeleton)
      --parameters string   Input parameters in JSON format

  === Parameter example ===

      --example   Output example parameters with JSON format

```


## ssh {: #ssh }

##### Usage
```console
Usage:
  ssh { ID | NAME | TAG } [flags]

Flags:

  === Server-specific options ===

  -i, --key string         
      --password string    (aliases: --pass-phrase)
  -p, --port int           (*required)  (default 22)
  -l, --user string        
      --wait-until-ready   (aliases: --wait)

  === Zone options ===

      --zone string   (*required) 

  === Input options ===

      --generate-skeleton   Output skeleton of parameters with JSON format (aliases: --skeleton)
      --parameters string   Input parameters in JSON format

  === Parameter example ===

      --example   Output example parameters with JSON format

```


## vnc {: #vnc }

##### Usage
```console
Usage:
  vnc { ID | NAME | TAG } [flags]

Flags:

  === Server-specific options ===

      --wait-until-ready   (aliases: --wait)

  === Zone options ===

      --zone string   (*required) 

  === Input options ===

      --generate-skeleton   Output skeleton of parameters with JSON format (aliases: --skeleton)
      --parameters string   Input parameters in JSON format

  === Parameter example ===

      --example   Output example parameters with JSON format

```


## rdp {: #rdp }

##### Usage
```console
Usage:
  rdp { ID | NAME | TAG } [flags]

Aliases:
  rdp, remote-desktop

Flags:

  === Server-specific options ===

      --port int            (default 3389)
      --user string         (default "Administrator")
      --wait-until-ready   (aliases: --wait)

  === Zone options ===

      --zone string   (*required) 

  === Input options ===

      --generate-skeleton   Output skeleton of parameters with JSON format (aliases: --skeleton)
      --parameters string   Input parameters in JSON format

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

  === Server-specific options ===

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


## monitor-cpu {: #monitor-cpu }

##### Usage
```console
Usage:
  monitor-cpu { ID | NAME | TAG }... [flags]

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


