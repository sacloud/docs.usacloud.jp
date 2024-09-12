# Terraform policy for さくらのクラウド

---

## 概要
`Terraform policy for さくらのクラウド` は、[Terraform for さくらのクラウド](https://docs.usacloud.jp/terraform/)を用いて記述されたTerraformコードを、セキュリティおよびガバナンスの観点から静的にチェックするためのポリシーです。

本ポリシーは[Rego](https://www.openpolicyagent.org/docs/latest/policy-language/)で記述されており、[OPA(Open Policy Agent)](https://www.openpolicyagent.org/)と[Conftest](https://www.conftest.dev/)に依存しています。

## 利用例

実行環境にOPAとConftestがインストールされていることが前提となります。

- [https://www.openpolicyagent.org/docs/latest/#running-opa](https://www.openpolicyagent.org/docs/latest/#running-opa)
- [https://www.conftest.dev/install/](https://www.conftest.dev/install/)

### ローカル環境での利用

Terraformコードの実装者がローカル環境で実行する方法です。
前述のとおり、ローカル環境にOPAとConftestがインストールされていることが前提となります。

```sh
# Run within the Terraform repository that uses the Terraform SakuraCloud provider
$ cd terraform

# Download the policy
$ conftest pull 'git::https://github.com/sacloud/terraform-provider-sakuracloud-policy.git//policy?ref=v1.1.0'

# Run the tests
$ conftest test . --ignore=".git/|.github/|.terraform/"
```

### GitHub Actionsでの利用

[GitHub Actions](https://docs.github.com/ja/actions) を用いて、CI（継続的インテグレーション）を行う方法です。

```yaml
name: conftest terraform policy check
on:
  pull_request:
env:
  CONFTEST_VERSION: 0.55.0
jobs:
  test:
    name: policy check
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4
        with:
          fetch-depth: 0

      - name: Install Conftest
        run: |
          mkdir -p $HOME/.local/bin
          echo "$HOME/.local/bin" >> $GITHUB_PATH
          wget -O - 'https://github.com/open-policy-agent/conftest/releases/download/v${{ env.CONFTEST_VERSION }}/conftest_${{ env.CONFTEST_VERSION }}_Linux_x86_64.tar.gz' | tar zxvf - -C $HOME/.local/bin

      - name: Conftest version
        run: conftest -v

      - name: download policy
        run: conftest pull 'git::https://github.com/sacloud/terraform-provider-sakuracloud-policy.git//policy?ref=v1.1.0'

      - name: run test
        run: conftest test . --ignore=".git/|.github/|.terraform/" --data="exception.json"
```

## Exception
ConftestのException機能を利用することで、特定のルールを例外扱いにできます。

Conftestの実行環境には、以下のようなYAML形式のファイルを追加します。このファイルには、例外扱いにしたいルールの名前を列挙します。

```yaml
exception:
  rule:
    - sakuracloud_disk_not_encrypted
```

そして、`conftest test` コマンドで [--data](https://www.conftest.dev/options/#-data) オプションを利用し、上記のファイルを読み込みます。

これにより、列挙されたルールが例外となり、`failures` ではなく `exception` としてカウントされます。

```sh
$ conftest test disk.tf --ignore=".git/|.github/|.terraform/" --data="exception.yml"
EXCP - disk.tf - main - data.main.exception[_][_] == "sakuracloud_disk_not_encrypted"

8 tests, 7 passed, 0 warnings, 0 failures, 1 exception
```

## カスタムポリシー
デフォルトで提供されるポリシーに加えて、ユーザーは独自のポリシーを追加できます。

例えば組織固有のルールを組み込むことで、組織独自のポリシーやガイドラインに準拠しているかチェックできます。

### 1. カスタムポリシーの作成
カスタムポリシーを記述した `.rego` ファイルを用意します。ファイルはTerraformコードと同じリポジトリ内で管理することを想定しています。

以下は `/custom-policy/sakuracloud_disk_too_small.rego` というファイルを作成した例です。

この例では、ディスクサイズが40GB未満の場合にエラーを返すカスタムポリシーを定義しています。

```rego
package main

import data.helpers.has_field
import rego.v1

deny_sakuracloud_disk_too_small contains msg if {
    resource := "sakuracloud_disk"
    rule := "sakuracloud_disk_too_small"

    some name
    disk := input.resource[resource][name]
    disk.size < 40

    msg := sprintf(
        "%s\nDisk is too small %s.%s\n",
        [rule, resource, name],
    )
}
```

### 2. conftestコマンドでカスタムポリシーを実行

以下のように `conftest test` コマンドの [--policy](https://www.conftest.dev/options/#-policy) オプションを利用して、デフォルトのポリシーに加えてカスタムポリシーも適用します。

このコマンドでは、`policy/` ディレクトリに配置されたデフォルトポリシーと、`custom-policy/` ディレクトリに配置されたカスタムポリシーの両方が適用されます。

```sh
$ conftest test disk.tf --ignore=".git/|.github/|.terraform/" --policy="policy/" --policy="custom-policy/"
FAIL - disk.tf - main - sakuracloud_disk_too_small
Disk is too small sakuracloud_disk.fail_disk_1

FAIL - disk.tf - main - sakuracloud_disk_not_encrypted
Disk encryption is not enabled in sakuracloud_disk.fail_disk_1
More Info: https://docs.usacloud.jp/terraform-policy/rules/sakuracloud_disk/not_encrypted/


9 tests, 7 passed, 0 warnings, 2 failures, 0 exceptions
```
