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
