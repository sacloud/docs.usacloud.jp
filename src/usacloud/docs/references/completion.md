# リファレンス / completion

```console
To load completions:

Bash:

$ source <(usacloud completion bash)

# To load completions for each session, execute once:
Linux:
  $ usacloud completion bash > /etc/bash_completion.d/usacloud
MacOS:
  $ usacloud completion bash > /usr/local/etc/bash_completion.d/usacloud

Zsh:

# If shell completion is not already enabled in your environment you will need
# to enable it.  You can execute the following once:

$ echo "autoload -U compinit; compinit" >> ~/.zshrc

# To load completions for each session, execute once:
$ usacloud completion zsh > "${fpath[1]}/_usacloud"

# You will need to start a new shell for this setup to take effect.

Fish:

$ usacloud completion fish | source

# To load completions for each session, execute once:
$ usacloud completion fish > ~/.config/fish/completions/usacloud.fish

Usage:
  usacloud completion [bash|zsh|fish|powershell]

Flags:
  -h, --help   help for completion
```
