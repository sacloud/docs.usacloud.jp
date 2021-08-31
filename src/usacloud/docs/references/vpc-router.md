# リファレンス / vpc-router

## コマンド一覧

- Basic Commands
    - [list](#list)
    - [create](#create)
    - [create-standard](#create-standard)
    - [read](#read)
    - [update](#update)
    - [update-standard](#update-standard)
    - [delete](#delete)
- Power Management Commands
    - [boot](#boot)
    - [shutdown](#shutdown)
    - [reset](#reset)
- Monitoring Commands
    - [monitor-interface](#monitor-interface)
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

  === Plan options ===

      --plan string   (*required) options: [premium/highspec/highspec4000] (default "premium")

  === Vpc-Router-specific options ===

      --boot-after-create             
      --dhcp-server string            
      --dhcp-static-mapping string    
      --firewall string               
      --internet-connection-enabled   
      --l2tp string                   
      --port-forwarding string        
      --pptp string                   
      --site-to-site-vpn string       
      --static-nat string             
      --static-route string           
      --syslog-host string            
      --users string                  
      --version int                   (*required)  (default 2)
      --vrid int                      
      --wireguard string              

  === Network options ===

      --public-network-interface-ip-addresses strings        
      --public-network-interface-ip-aliases strings          
      --public-network-interface-switch-id int               
      --public-network-interface-virtual-ip-address string   
      --private-network-interfaces string                    

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
    "Plan": "premium | highspec | highspec4000",
    "Version": 2,
    "PublicNetworkInterface": {
        "SwitchID": 123456789012,
        "IPAddresses": [
            "192.0.2.21",
            "192.0.2.22"
        ],
        "VirtualIPAddress": "192.0.2.101",
        "IPAliases": [
            "192.0.2.102"
        ]
    },
    "PrivateNetworkInterfaces": [
        {
            "SwitchID": 123456789012,
            "IPAddresses": [
                "192.168.0.11",
                "192.168.0.12"
            ],
            "VirtualIPAddress": "192.168.0.1",
            "NetworkMaskLen": 24,
            "Index": 1
        }
    ],
    "RouterSetting": {
        "VRID": 1,
        "InternetConnectionEnabled": true,
        "StaticNAT": [
            {
                "GlobalAddress": "192.0.2.101",
                "PrivateAddress": "192.168.0.1",
                "Description": "example"
            }
        ],
        "PortForwarding": [
            {
                "Protocol": "tcp | udp",
                "GlobalPort": "22",
                "PrivateAddress": "192.168.0.11",
                "PrivatePort": "22",
                "Description": "example"
            }
        ],
        "Firewall": [
            {
                "Send": [
                    {
                        "Protocol": "tcp | udp | icmp | ip",
                        "SourceNetwork": "192.0.2.1 | 192.0.2.0/24",
                        "SourcePort": "1024 | 1024-2048",
                        "DestinationNetwork": "192.0.2.1 | 192.0.2.0/24",
                        "DestinationPort": "1024 | 1024-2048",
                        "Action": "allow | deny",
                        "Logging": "True",
                        "Description": "example"
                    }
                ],
                "Receive": [
                    {
                        "Protocol": "tcp | udp | icmp | ip",
                        "SourceNetwork": "192.0.2.1 | 192.0.2.0/24",
                        "SourcePort": "1024 | 1024-2048",
                        "DestinationNetwork": "192.0.2.1 | 192.0.2.0/24",
                        "DestinationPort": "1024 | 1024-2048",
                        "Action": "allow | deny",
                        "Logging": "True",
                        "Description": "example"
                    }
                ],
                "Index": 0
            }
        ],
        "DHCPServer": [
            {
                "Interface": "eth1",
                "RangeStart": "192.168.0.240",
                "RangeStop": "192.168.0.244",
                "DNSServers": [
                    "133.242.0.3",
                    "133.242.0.4"
                ]
            }
        ],
        "DHCPStaticMapping": [
            {
                "MACAddress": "9C:A3:BA:xx:xx:xx",
                "IPAddress": "192.168.0.245"
            }
        ],
        "PPTPServer": {
            "RangeStart": "192.168.0.246",
            "RangeStop": "192.168.0.249"
        },
        "L2TPIPsecServer": {
            "RangeStart": "192.168.0.250",
            "RangeStop": "192.168.0.254",
            "PreSharedSecret": "presharedsecret"
        },
        "RemoteAccessUsers": [
            {
                "UserName": "username",
                "Password": "password"
            }
        ],
        "WireGuard": {
            "IPAddress": "192.168.0.240/28",
            "Peers": [
                {
                    "Name": "client1",
                    "IPAddress": "192.168.0.242",
                    "PublicKey": "your-key"
                }
            ]
        },
        "SiteToSiteIPsecVPN": [
            {
                "Peer": "192.0.2.1",
                "PreSharedSecret": "presharedsecret",
                "RemoteID": "192.0.2.1",
                "Routes": [
                    "10.0.0.0/8"
                ],
                "LocalPrefix": [
                    "192.168.0.0/24"
                ]
            }
        ],
        "StaticRoute": [
            {
                "Prefix": "172.16.0.0/16",
                "NextHop": "192.168.0.21"
            }
        ],
        "SyslogHost": "192.168.0.1"
    },
    "BootAfterCreate": true,
    "NoWait": false
}
```


## create-standard {: #create-standard }

##### Usage
```console
Usage:
  create-standard [flags]

Flags:

  === Common options ===

      --name string          (*required) 
      --description string   
      --tags strings         
      --icon-id int          

  === Vpc-Router-specific options ===

      --boot-after-create                   
      --dhcp-server string                  
      --dhcp-static-mapping string          
      --firewall string                     
      --internet-connection-enabled         
      --l2tp string                         
      --port-forwarding string              
      --pptp string                         
      --private-network-interfaces string   
      --site-to-site-vpn string             
      --static-nat string                   
      --static-route string                 
      --syslog-host string                  
      --users string                        
      --version int                         (*required)  (default 2)
      --vrid int                            
      --wireguard string                    

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
    "Version": 2,
    "PrivateNetworkInterfacesData": "",
    "PrivateNetworkInterfaces": [
        {
            "SwitchID": 123456789012,
            "IPAddress": "192.168.0.11",
            "NetworkMaskLen": 24,
            "Index": 1
        }
    ],
    "RouterSetting": {
        "InternetConnectionEnabled": true,
        "PortForwarding": [
            {
                "Protocol": "tcp | udp",
                "GlobalPort": "22",
                "PrivateAddress": "192.168.0.11",
                "PrivatePort": "22",
                "Description": "example"
            }
        ],
        "Firewall": [
            {
                "Send": [
                    {
                        "Protocol": "tcp | udp | icmp | ip",
                        "SourceNetwork": "192.0.2.1 | 192.0.2.0/24",
                        "SourcePort": "1024 | 1024-2048",
                        "DestinationNetwork": "192.0.2.1 | 192.0.2.0/24",
                        "DestinationPort": "1024 | 1024-2048",
                        "Action": "allow | deny",
                        "Logging": "True",
                        "Description": "example"
                    }
                ],
                "Receive": [
                    {
                        "Protocol": "tcp | udp | icmp | ip",
                        "SourceNetwork": "192.0.2.1 | 192.0.2.0/24",
                        "SourcePort": "1024 | 1024-2048",
                        "DestinationNetwork": "192.0.2.1 | 192.0.2.0/24",
                        "DestinationPort": "1024 | 1024-2048",
                        "Action": "allow | deny",
                        "Logging": "True",
                        "Description": "example"
                    }
                ],
                "Index": 0
            }
        ],
        "DHCPServer": [
            {
                "Interface": "eth1",
                "RangeStart": "192.168.0.240",
                "RangeStop": "192.168.0.244",
                "DNSServers": [
                    "133.242.0.3",
                    "133.242.0.4"
                ]
            }
        ],
        "DHCPStaticMapping": [
            {
                "MACAddress": "9C:A3:BA:xx:xx:xx",
                "IPAddress": "192.168.0.245"
            }
        ],
        "PPTPServer": {
            "RangeStart": "192.168.0.246",
            "RangeStop": "192.168.0.249"
        },
        "L2TPIPsecServer": {
            "RangeStart": "192.168.0.250",
            "RangeStop": "192.168.0.254",
            "PreSharedSecret": "presharedsecret"
        },
        "RemoteAccessUsers": [
            {
                "UserName": "username",
                "Password": "password"
            }
        ],
        "WireGuard": {
            "IPAddress": "192.168.0.240/28",
            "Peers": [
                {
                    "Name": "client1",
                    "IPAddress": "192.168.0.242",
                    "PublicKey": "your-key"
                }
            ]
        },
        "SiteToSiteIPsecVPN": [
            {
                "Peer": "192.0.2.1",
                "PreSharedSecret": "presharedsecret",
                "RemoteID": "192.0.2.1",
                "Routes": [
                    "10.0.0.0/8"
                ],
                "LocalPrefix": [
                    "192.168.0.0/24"
                ]
            }
        ],
        "StaticRoute": [
            {
                "Prefix": "172.16.0.0/16",
                "NextHop": "192.168.0.21"
            }
        ],
        "SyslogHost": "192.168.0.1"
    },
    "BootAfterCreate": true,
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

  === Vpc-Router-specific options ===

      --dhcp-server string            
      --dhcp-static-mapping string    
      --firewall string               
      --internet-connection-enabled   
      --l2tp string                   
      --port-forwarding string        
      --pptp string                   
      --site-to-site-vpn string       
      --static-nat string             
      --static-route string           
      --syslog-host string            
      --users string                  
      --wireguard string              

  === Network options ===

      --public-network-interface-ip-addresses strings        
      --public-network-interface-ip-aliases strings          
      --public-network-interface-virtual-ip-address string   
      --private-network-interfaces string                    

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
    "PublicNetworkInterface": {
        "IPAddresses": [
            "192.0.2.21",
            "192.0.2.22"
        ],
        "VirtualIPAddress": "192.0.2.101",
        "IPAliases": [
            "192.0.2.102"
        ]
    },
    "PrivateNetworkInterfaces": [
        {
            "SwitchID": 123456789012,
            "IPAddresses": [
                "192.168.0.11",
                "192.168.0.12"
            ],
            "VirtualIPAddress": "192.168.0.1",
            "NetworkMaskLen": 24,
            "Index": 1
        }
    ],
    "RouterSetting": {
        "InternetConnectionEnabled": true,
        "StaticNATData": "",
        "StaticNAT": [
            {
                "GlobalAddress": "192.0.2.101",
                "PrivateAddress": "192.168.0.1",
                "Description": "example"
            }
        ],
        "PortForwardingData": "",
        "PortForwarding": [
            {
                "Protocol": "tcp | udp",
                "GlobalPort": "22",
                "PrivateAddress": "192.168.0.11",
                "PrivatePort": "22",
                "Description": "example"
            }
        ],
        "FirewallData": "",
        "Firewall": [
            {
                "Send": [
                    {
                        "Protocol": "tcp | udp | icmp | ip",
                        "SourceNetwork": "192.0.2.1 | 192.0.2.0/24",
                        "SourcePort": "1024 | 1024-2048",
                        "DestinationNetwork": "192.0.2.1 | 192.0.2.0/24",
                        "DestinationPort": "1024 | 1024-2048",
                        "Action": "allow | deny",
                        "Logging": "True",
                        "Description": "example"
                    }
                ],
                "Receive": [
                    {
                        "Protocol": "tcp | udp | icmp | ip",
                        "SourceNetwork": "192.0.2.1 | 192.0.2.0/24",
                        "SourcePort": "1024 | 1024-2048",
                        "DestinationNetwork": "192.0.2.1 | 192.0.2.0/24",
                        "DestinationPort": "1024 | 1024-2048",
                        "Action": "allow | deny",
                        "Logging": "True",
                        "Description": "example"
                    }
                ],
                "Index": 0
            }
        ],
        "DHCPServerData": "",
        "DHCPServer": [
            {
                "Interface": "eth1",
                "RangeStart": "192.168.0.240",
                "RangeStop": "192.168.0.244",
                "DNSServers": [
                    "133.242.0.3",
                    "133.242.0.4"
                ]
            }
        ],
        "DHCPStaticMappingData": "",
        "DHCPStaticMapping": [
            {
                "MACAddress": "9C:A3:BA:xx:xx:xx",
                "IPAddress": "192.168.0.245"
            }
        ],
        "PPTPServerData": "",
        "PPTPServer": {
            "RangeStart": "192.168.0.246",
            "RangeStop": "192.168.0.249"
        },
        "L2TPIPsecServerData": "",
        "L2TPIPsecServer": {
            "RangeStart": "192.168.0.250",
            "RangeStop": "192.168.0.254",
            "PreSharedSecret": "presharedsecret"
        },
        "WireGuardData": "",
        "WireGuard": {
            "IPAddress": "192.168.0.240/28",
            "Peers": [
                {
                    "Name": "client1",
                    "IPAddress": "192.168.0.242",
                    "PublicKey": "your-key"
                }
            ]
        },
        "RemoteAccessUsersData": "",
        "RemoteAccessUsers": [
            {
                "UserName": "username",
                "Password": "password"
            }
        ],
        "SiteToSiteIPsecVPNData": "",
        "SiteToSiteIPsecVPN": [
            {
                "Peer": "192.0.2.1",
                "PreSharedSecret": "presharedsecret",
                "RemoteID": "192.0.2.1",
                "Routes": [
                    "10.0.0.0/8"
                ],
                "LocalPrefix": [
                    "192.168.0.0/24"
                ]
            }
        ],
        "StaticRouteData": "",
        "StaticRoute": [
            {
                "Prefix": "172.16.0.0/16",
                "NextHop": "192.168.0.21"
            }
        ],
        "SyslogHost": "192.168.0.1"
    },
    "NoWait": false
}
```


## update-standard {: #update-standard }

##### Usage
```console
Usage:
  update-standard { ID | NAME | TAG }... [flags]

Flags:

  === Common options ===

      --name string          
      --description string   
      --tags strings         
      --icon-id int          

  === Vpc-Router-specific options ===

      --dhcp-server string                  
      --dhcp-static-mapping string          
      --firewall string                     
      --internet-connection-enabled         
      --l2tp string                         
      --port-forwarding string              
      --pptp string                         
      --private-network-interfaces string   
      --site-to-site-vpn string             
      --static-nat string                   
      --static-route string                 
      --syslog-host string                  
      --users string                        
      --wireguard string                    

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
    "PrivateNetworkInterfaces": [
        {
            "SwitchID": 123456789012,
            "IPAddress": "192.168.0.11",
            "NetworkMaskLen": 24,
            "Index": 1
        }
    ],
    "RouterSetting": {
        "InternetConnectionEnabled": true,
        "StaticNATData": "",
        "StaticNAT": null,
        "PortForwardingData": "",
        "PortForwarding": [
            {
                "Protocol": "tcp | udp",
                "GlobalPort": "22",
                "PrivateAddress": "192.168.0.11",
                "PrivatePort": "22",
                "Description": "example"
            }
        ],
        "FirewallData": "",
        "Firewall": [
            {
                "Send": [
                    {
                        "Protocol": "tcp | udp | icmp | ip",
                        "SourceNetwork": "192.0.2.1 | 192.0.2.0/24",
                        "SourcePort": "1024 | 1024-2048",
                        "DestinationNetwork": "192.0.2.1 | 192.0.2.0/24",
                        "DestinationPort": "1024 | 1024-2048",
                        "Action": "allow | deny",
                        "Logging": "True",
                        "Description": "example"
                    }
                ],
                "Receive": [
                    {
                        "Protocol": "tcp | udp | icmp | ip",
                        "SourceNetwork": "192.0.2.1 | 192.0.2.0/24",
                        "SourcePort": "1024 | 1024-2048",
                        "DestinationNetwork": "192.0.2.1 | 192.0.2.0/24",
                        "DestinationPort": "1024 | 1024-2048",
                        "Action": "allow | deny",
                        "Logging": "True",
                        "Description": "example"
                    }
                ],
                "Index": 0
            }
        ],
        "DHCPServerData": "",
        "DHCPServer": [
            {
                "Interface": "eth1",
                "RangeStart": "192.168.0.240",
                "RangeStop": "192.168.0.244",
                "DNSServers": [
                    "133.242.0.3",
                    "133.242.0.4"
                ]
            }
        ],
        "DHCPStaticMappingData": "",
        "DHCPStaticMapping": [
            {
                "MACAddress": "9C:A3:BA:xx:xx:xx",
                "IPAddress": "192.168.0.245"
            }
        ],
        "PPTPServerData": "",
        "PPTPServer": {
            "RangeStart": "192.168.0.246",
            "RangeStop": "192.168.0.249"
        },
        "L2TPIPsecServerData": "",
        "L2TPIPsecServer": {
            "RangeStart": "192.168.0.250",
            "RangeStop": "192.168.0.254",
            "PreSharedSecret": "presharedsecret"
        },
        "WireGuardData": "",
        "WireGuard": {
            "IPAddress": "192.168.0.240/28",
            "Peers": [
                {
                    "Name": "client1",
                    "IPAddress": "192.168.0.242",
                    "PublicKey": "your-key"
                }
            ]
        },
        "RemoteAccessUsersData": "",
        "RemoteAccessUsers": [
            {
                "UserName": "username",
                "Password": "password"
            }
        ],
        "SiteToSiteIPsecVPNData": "",
        "SiteToSiteIPsecVPN": [
            {
                "Peer": "192.0.2.1",
                "PreSharedSecret": "presharedsecret",
                "RemoteID": "192.0.2.1",
                "Routes": [
                    "10.0.0.0/8"
                ],
                "LocalPrefix": [
                    "192.168.0.0/24"
                ]
            }
        ],
        "StaticRouteData": "",
        "StaticRoute": [
            {
                "Prefix": "172.16.0.0/16",
                "NextHop": "192.168.0.21"
            }
        ],
        "SyslogHost": "192.168.0.1"
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

  === Vpc-Router-specific options ===

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

  === Vpc-Router-specific options ===

      --index int   

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


