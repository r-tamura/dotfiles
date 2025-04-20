# dotfiles

dotfiles for devcontainers or codespaces

## DevContainerでdotfilesを使うように設定

1. ユーザのsettings.jsonにこのレポジトリを追加

```json:settings.json
{
  "dotfiles.repository": "https://github.com/r-tamura/dotfiles.git",
}
```

2. DevContainerを起動

## Troubleshooting

### dotfilesのコマンドがDevContainerインストールされない

DevContainer起動時のログを確認する

1. `Ctrl + Shift + P` でコマンドパレットを開く
2. `Dev Containers: Show Container Logs` を選択
