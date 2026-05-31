# 📦 打包好的程序 / Prebuilt Binaries

clone 仓库后,这里就是**开箱即用的成品**,不用自己编译。
After cloning, these are **ready-to-run** builds. No compiling needed.

## Windows

进入 `windows/` 文件夹,双击 **`启动.bat`** 即可。
Open `windows/`, double-click **`启动.bat`**.

- `pearl-proxy.exe` — 主程序(已混淆加固)
- `config.json` — 配置(先改面板密码 `dashboard.password`)
- `启动.bat` — 一键启动

## Linux

```bash
cd linux
chmod +x pearl-proxy start.sh
./start.sh
```

- `pearl-proxy` — 主程序(已混淆加固)
- `config.json` — 配置(先改面板密码)
- `start.sh` — 一键启动

## 启动后 / After start

| 用途 | 地址 |
|------|------|
| 矿机连这里 / Point miners | `stratum+tcp://你的IP:3333` |
| Web 管理面板 / Dashboard | `http://你的IP:8080` (账号 admin) |

> ⚠️ 公网部署请先改 `config.json` 里的面板密码,并放行防火墙 3333 / 8080 端口。
> Change the dashboard password and open ports 3333 / 8080 before exposing publicly.
