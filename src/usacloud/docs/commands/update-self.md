# コマンドリファレンス / update-self

GitHub APIで最新バージョンがリリースされているかの確認を行い、リリースされていたらUsacloud自身のバージョンアップを行います。  

```console
Update Usacloud to latest-stable version

Usage:
  usacloud update-self

Flags:
  -h, --help   help for update-self
```

!!! Info
    `update-self`コマンドがGitHub APIを呼ぶ際、環境変数`GITHUB_TOKEN`がセットされている、または`gitconfig`の`github.token`が設定されている場合はそれらを利用します。
