# Terraform policy for さくらのクラウド

---

## 概要
`Terraform policy for さくらのクラウド` は、[Terraform for さくらのクラウド](https://docs.usacloud.jp/terraform/)を利用して記述されたTerraformコードを、セキュリティ・ガバナンスの観点で静的チェックするためのポリシーです。

本ポリシーは[Rego](https://www.openpolicyagent.org/docs/latest/policy-language/)で記述されており、[OPA(Open Policy Agent)](https://www.openpolicyagent.org/)と[Conftest](https://www.conftest.dev/)に依存しています。

## 利用例

```sh
# Run within the Terraform repository that uses the Terraform SakuraCloud provider
$ cd terraform

# Download the policy
$ conftest pull 'git@github.com:sacloud/terraform-provider-sakuracloud-policy.git//policy?ref=v1.0.0'

# Run the tests
$ conftest test . --ignore=".git/|.github/|.terraform/"
```
