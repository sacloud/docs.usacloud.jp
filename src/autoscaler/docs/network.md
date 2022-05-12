# 水平スケールでのネットワーク

AutoScalerは水平スケールの際、コンフィギュレーションに沿ってIPアドレス/サブネットマスク長/ゲートウェイを各サーバに割り当てます。  

## 水平スケール時のネットワーク設定の算出

Coreはコンフィギュレーションと対象サーバのサーバグループ内でのインデックスを元にネットワーク設定を算出してHandlersに渡します。  

### コンフィギュレーションでのネットワーク関連項目の指定

まず、コンフィギュレーションではNICごとに以下の情報を指定する必要があります。

`template.network_interfaces`の要素として以下を指定:

- `upstream`: NICをどこに接続するか(共有セグメント or スイッチ)  
- `assign_cidr_block`: 割り当てるIPアドレスブロック(CIDR表記)  
- `assign_netmask_len`: 割り当てるサブネットマスク長  
- `default_route`: 割り当てるデフォルトゲートウェイのIPアドレス  

!!! Info
    `upstream`が共有セグメント(`shared`)の場合、IPアドレスやサブネットマスク長、デフォルトゲートウェイはさくらのクラウド側で割り当てられるため指定できません。

設定例:
```yaml
# 抜粋
resources:
  - type: ServerGroup
    zone: "is1a"
    
    template: 
      network_interfaces:
        - upstream: "shared"
        
        - upstream:
            names: ["example"]
          assign_cidr_block: "192.168.0.32/28"
          assign_netmask_len: 24
```

この例は以下のような指定となっています。

- NICは2つ
- 1番目のNICは共有セグメントに接続
    - IPアドレス/サブネットマスク長/デフォルトゲートウェイはさくらのクラウド側が割り当て
- 2番目のNICは`examples`というスイッチに接続
    - IPアドレスは`192.168.0.32/28`の範囲内から割り当て
    - サブネットマスク長は`24`

作成されるサーバのサーバグループ内でのインデックスに応じて`assign_cidr_block`から対応するIPアドレスが割り当てられます。  
上記の例だと、インデックスが`0`の場合は`192.168.0.33`、`1`の場合は`192.168.0.34`が割り当てられます。

### 割り当てられたネットワーク情報のサーバへの反映

上記で割り当てられるネットワーク情報はAutoScaler上での論理的な値となっており、最終的にサーバに反映させる必要があります。  
1番目のNIC、かつ利用するアーカイブが[ディスクの修正API](https://manual.sakura.ad.jp/cloud/storage/modifydisk/about.html)に対応している場合はHandlersが自動的にサーバに反映させます。

2番目以降のNIC、またはディスクの修正APIに対応していない場合はスタートアップスクリプトやcloud-initを用いてサーバに反映させる必要があります。

#### スタートアップスクリプトでIPアドレスの設定を行う例

AutoScalerでスタートアップスクリプトを指定する場合、[Goのテンプレート](https://pkg.go.dev/text/template)を用いることでサーバに割り当てられたネットワーク情報をスクリプトに組み込み可能です。

eth1の設定例:

```bash
#!/bin/bash

# eth1向け設定ファイル作成
cat <<EOL >> /etc/netplan/99-eth1-netcfg.yaml
network:
  ethernets:
    eth1:
      addresses:
        # パラメータ中のNetworkInterfacesからインデックス1の要素を取り出し、N.N.N.N/N形式で出力する
        - {{ with index .NetworkInterfaces 1 }}{{ with .AssignedNetwork }}{{ .IpAddress }}/{{ .Netmask }}{{ end }}{{ end }}
      dhcp4: 'no'
      dhcp6: 'no'
EOL

# 反映
netplan apply
```

Goのテンプレートでは以下のパラメータが利用可能です。  
詳細: [github.com/sacloud/autoscaler - handler/handler.pb.go](https://github.com/sacloud/autoscaler/blob/main/handler/handler.pb.go)

```go
type ServerGroupInstance struct {
	Parent *Parent `protobuf:"bytes,1,opt,name=parent,proto3" json:"parent,omitempty"`
	Id     string  `protobuf:"bytes,11,opt,name=id,proto3" json:"id,omitempty"` // 新規作成指示時は空
	Zone   string  `protobuf:"bytes,12,opt,name=zone,proto3" json:"zone,omitempty"`
	
	// plan
	Core          uint32 `protobuf:"varint,13,opt,name=core,proto3" json:"core,omitempty"`
	Memory        uint32 `protobuf:"varint,14,opt,name=memory,proto3" json:"memory,omitempty"`
	DedicatedCpu  bool   `protobuf:"varint,15,opt,name=dedicated_cpu,json=dedicatedCpu,proto3" json:"dedicated_cpu,omitempty"`
	PrivateHostId string `protobuf:"bytes,16,opt,name=private_host_id,json=privateHostId,proto3" json:"private_host_id,omitempty"`
	
	// disks
	Disks []*ServerGroupInstance_Disk `protobuf:"bytes,17,rep,name=disks,proto3" json:"disks,omitempty"`
	
	// ディスクの修正関連
	EditParameter *ServerGroupInstance_EditParameter `protobuf:"bytes,18,opt,name=edit_parameter,json=editParameter,proto3" json:"edit_parameter,omitempty"` // 1番目のディスクにのみ有効
	CloudConfig   string                             `protobuf:"bytes,27,opt,name=cloud_config,json=cloudConfig,proto3" json:"cloud_config,omitempty"`
	
	// networks
	NetworkInterfaces []*ServerGroupInstance_NIC `protobuf:"bytes,19,rep,name=network_interfaces,json=networkInterfaces,proto3" json:"network_interfaces,omitempty"`
	
	// misc
	CdRomId         string `protobuf:"bytes,20,opt,name=cd_rom_id,json=cdRomId,proto3" json:"cd_rom_id,omitempty"`
	InterfaceDriver string `protobuf:"bytes,21,opt,name=interface_driver,json=interfaceDriver,proto3" json:"interface_driver,omitempty"`
	
	// common
	Name          string   `protobuf:"bytes,22,opt,name=name,proto3" json:"name,omitempty"`
	Tags          []string `protobuf:"bytes,23,rep,name=tags,proto3" json:"tags,omitempty"`
	Description   string   `protobuf:"bytes,24,opt,name=description,proto3" json:"description,omitempty"`
	IconId        string   `protobuf:"bytes,25,opt,name=icon_id,json=iconId,proto3" json:"icon_id,omitempty"`
	ShutdownForce bool     `protobuf:"varint,26,opt,name=shutdown_force,json=shutdownForce,proto3" json:"shutdown_force,omitempty"`
}
```

スタートアップスクリプトを用いるコンフィギュレーションの例は[Examples: LB + サーバの水平スケール](../examples/horizontal-scale-server-and-lb/)を参照してください。