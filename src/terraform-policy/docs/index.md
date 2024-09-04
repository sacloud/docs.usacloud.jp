# Terraform policy for さくらのクラウド

---

## 概要
`Terraform policy for さくらのクラウド` は、[Terraform for さくらのクラウド](https://docs.usacloud.jp/terraform/)を用いて記述されたTerraformコードを、セキュリティおよびガバナンスの観点から静的にチェックするためのポリシーです。

本ポリシーは[Rego](https://www.openpolicyagent.org/docs/latest/policy-language/)で記述されており、[OPA(Open Policy Agent)](https://www.openpolicyagent.org/)と[Conftest](https://www.conftest.dev/)に依存しています。

## 利用例

本ポリシーを使用する前に、実行環境にOPAとConftestがインストールされていることが前提となります。

- [https://www.openpolicyagent.org/docs/latest/#running-opa](https://www.openpolicyagent.org/docs/latest/#running-opa)
- [https://www.conftest.dev/install/](https://www.openpolicyagent.org/docs/latest/#running-opa)

```sh
# Run within the Terraform repository that uses the Terraform SakuraCloud provider
$ cd terraform

# Download the policy
$ conftest pull 'git::https://github.com/sacloud/terraform-provider-sakuracloud-policy.git//policy?ref=v1.0.0'

# Run the tests
$ conftest test . --ignore=".git/|.github/|.terraform/"
```
