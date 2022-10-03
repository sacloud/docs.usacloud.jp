# アップグレードガイド(v2.18)

## 目次

- [アーカイブ: os_typeに指定可能な値の更新](#diff1)
  
### アーカイブ: os_typeに指定可能な値の更新 {: #diff1 }

さくらのクラウドでのパブリックアーカイブ更新に伴い、os_typeに指定可能な値も更新されました。  

#### 新たに追加された項目

- `almalinux9`
- `almalinux8`
- `rockylinux9`
- `rockylinux8`
- `miracle8`/ `miraclelinux8`

#### 削除された項目

- `centos8stream`
- `rancheros`
- `k3os`

!!! warning
    `centos8stream`の提供終了に伴い、`centos`を利用していた場合はCentOS7がヒットするようになりました。