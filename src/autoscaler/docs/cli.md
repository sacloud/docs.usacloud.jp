# AutoScaler CLIリファレンス

## 利用方法/ヘルプ

`autoscaler -h`でヘルプが表示されます。

```shell
$ autoscaler -h
autoscaler is a tool for managing the scale of resources on SAKURA cloud

Usage:
  autoscaler [command]

Available Commands:
  completion  Generate completion script
  example     show configuration example
  handlers    A set of sub commands to manage autoscaler's external handlers
  help        Help about any command
  inputs      A set of sub commands to manage autoscaler's inputs
  resources   list target resources
  start       start autoscaler's core server
  validate    validate autoscaler's core configuration
  version     show version

Flags:
  -h, --help                help for autoscaler
      --log-format string   Format of logging to be output. options: [ logfmt | json ] (default "logfmt")
      --log-level string    Level of logging to be output. options: [ error | warn | info | debug ] (default "info")
  -v, --version             version for autoscaler

Use "autoscaler [command] --help" for more information about a command.
```

指定可能なサブコマンドやオプションは各コマンドのヘルプを参照してください。

## シェル補完

sacloud/autoscalerはシェル補完に対応しています。  
シェル補完の有効化方法はご利用のシェルごとに異なります。

`autoscaler completion --help`で表示される手順に従ってください。  

### シェル補完の設定例

#### Bash

```bash
$ source <(autoscaler completion bash)

# To load completions for each session, execute once:
# Linux:
$ autoscaler completion bash > /etc/bash_completion.d/autoscaler
# macOS:
$ autoscaler completion bash > /usr/local/etc/bash_completion.d/autoscaler
```

#### Zsh

```zsh
# If shell completion is not already enabled in your environment,
# you will need to enable it.  You can execute the following once:

$ echo "autoload -U compinit; compinit" >> ~/.zshrc

# To load completions for each session, execute once:
$ autoscaler completion zsh > "${fpath[1]}/_autoscaler"

# You will need to start a new shell for this setup to take effect.
```

#### fish

```fish
$ autoscaler completion fish | source

# To load completions for each session, execute once:
$ autoscaler completion fish > ~/.config/fish/completions/autoscaler.fish
```

#### PowerShell

```powershell
PS> autoscaler completion powershell | Out-String | Invoke-Expression

# To load completions for every new session, run:
PS> autoscaler completion powershell > autoscaler.ps1
# and source this file from your PowerShell profile.
```