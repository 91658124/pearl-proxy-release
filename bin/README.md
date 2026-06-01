# 成品二进制（clone 即用）

| 平台 | 怎么用 |
|------|--------|
| 🐧 Linux | 进 `linux/`，编辑 `config.json` 改面板密码，`./start.sh` |
| 🪟 Windows | 进 `windows/`，编辑 `config.json` 改面板密码，双击 `启动.bat` |

二进制经混淆加壳，作者底费 0.3% 已内置固定，改 `config.json` 也改不掉。
矿机接入：`stratum+tcp://<本机IP>:3333 --wallet <你的PRL地址>.<worker>`
面板默认仅本机 `127.0.0.1:8080`，远程查看用 SSH 隧道。

也可从 [Releases](../../releases/latest) 下载单文件版 + 一键安装脚本。
