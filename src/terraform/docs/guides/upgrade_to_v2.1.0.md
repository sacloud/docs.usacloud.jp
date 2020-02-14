# アップグレードガイド(v2.1.0)

## 目次

- [追加/変更/削除されたリソース](#generalDiff)
- [各リソースの変更点](#diffDetail)
    - [データソースの変更点](#diffDetailDataSource)
        - [コンテナレジストリ: `container_registry`](#dataSourceContainerRegistry)
    - [リソースの変更点](#diffDetailResource)
        - [データベース: `sakuracloud_database`](#resourceDatabase)
        - [コンテナレジストリ: `container_registry`](#resourceContainerRegistry)
    
# 追加/変更/削除されたリソース {: #generalDiff }

#### データソース

- [コンテナレジストリ: `container_registry`](#dataSourceContainerRegistry)

#### リソース

- [コンテナレジストリ: `container_registry`](#resourceDatabase)
- [データベース: `sakuracloud_database`](#resourceContainerRegistry)

# 各リソースの変更点 {: #diffDetail }

## データソースの変更点 {: #diffDetailDataSource }

### [コンテナレジストリ: `sakuracloud_container_registry`](https://docs.usacloud.jp/terraform/d/container_registry) {: #dataSourceContainerRegistry}

ドキュメント: [https://docs.usacloud.jp/terraform/d/container_registry](https://docs.usacloud.jp/terraform/d/container_registry)

- `users`ブロックを追加
- `users`ブロック内に`permission`を追加
- `virtual_domain`を追加

---


## リソースの変更点 {: #diffDetailResource }

### [コンテナレジストリ: `sakuracloud_container_registry`](https://docs.usacloud.jp/terraform/r/container_registry) {: #resourceContainerRegistry}

ドキュメント: [https://docs.usacloud.jp/terraform/r/container_registry](https://docs.usacloud.jp/terraform/r/container_registry)

- `users`ブロック内に`permission`を追加
- `virtual_domain`を追加

---

### [データベースアプライアンス: `sakuracloud_database`](https://docs.usacloud.jp/terraform/r/database) {: #resourceDatabase}

ドキュメント: [https://docs.usacloud.jp/terraform/r/database](https://docs.usacloud.jp/terraform/r/database)

- PostgreSQL 12.1

!!! Note
    tfファイル上の項目の変更はありません。  
    既存データベースアプライアンスのPostgreSQLのバージョンをあげたい場合は再作成が必要です。

---
