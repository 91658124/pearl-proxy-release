# pearl-proxy · 珍珠币(PEARL/PRL)矿池中转加速器

> 这是**发布仓库**,只提供编译好的可执行文件、一键安装脚本和使用说明。
> This is the **release repo** — prebuilt binaries, one-click installers, and usage docs only.

部署在中转服务器上,矿机先连你的服务器,服务器再用复用长连接转发到矿池。两大核心能力:

- **🚀 中转加速**:就近接入 + 长连接复用 + 自动断线重连,降低延迟、减少掉线,配套统一可视化面板看清所有矿机的算力/份额/在线状态。
- **💎 透明抽水**:可选的 dev-fee 抽水(时间片方式,面板实时公开比例)。作者底费 0.3%,运营者可自定义自己的抽水档位,叠加按比例分成——既能为下游矿工提供加速服务,你也能从中获得收益。

This is a stratum mining relay/proxy: miners connect to your server, the server multiplexes one upstream connection to the pool — lower latency, auto-reconnect, a unified dashboard, plus an optional **transparent dev-fee** so you can monetize the service.

## ⬇️ 直接下载(打包好的程序,开箱即用)/ Download

> 下面是**编译好的成品程序**,内置 Web 管理面板,下载即用,无需安装环境。
> Prebuilt binaries with a built-in web dashboard. No runtime needed.

| 系统 / OS | 仓库内直接下载 / In-repo | 说明 |
|------|------|------|
| 🪟 Windows 64位 | **[📂 bin/windows/](bin/windows/)** → 双击 `启动.bat` | 程序+配置+一键启动,开箱即用 |
| 🐧 Linux 64位 | **[📂 bin/linux/](bin/linux/)** → `./start.sh` | 程序+配置+一键启动,开箱即用 |
| 🔐 校验和 | [SHA256SUMS.txt](https://github.com/Forlives/pearl-proxy-release/releases/latest/download/SHA256SUMS.txt) | 校验文件完整性 |

也可在右侧 **[Releases](https://github.com/Forlives/pearl-proxy-release/releases/latest)** 页下载单文件版本。
Binaries also live in [`bin/`](bin/) right inside this repo — clone and run, nothing to compile.

**运行后**:浏览器打开 `http://你的服务器IP:8080` 进入 **Web 管理面板**(默认账号 admin),矿机指向 `你的服务器IP:3333` 即可。
After launch, open `http://YOUR_IP:8080` for the **web dashboard**, point miners to `YOUR_IP:3333`.

## ✨ 特性 / Features

- 🚀 **加速降延迟** — 就近接入 + 长连接复用,减少握手与抖动
- 🔄 **自动重连** — 矿池断线代理自动重连,矿机无感
- 📊 **实时面板** — Web 控制台,所有矿机的算力/份额/在线状态一目了然
- 🛡️ **防 DDoS** — 每 IP 并发上限、连接限速、IP 黑白名单
- 💎 **透明抽水** — 抽水比例在面板实时公开(行业通用 dev-fee 做法)
- 🔒 **TLS 可选** — 上游矿池支持时加密链路

## 📦 一键安装 / One-Click Install

### Linux

```bash
curl -fsSL https://github.com/Forlives/pearl-proxy-release/raw/main/scripts/install.sh -o install.sh
sudo bash install.sh
```

脚本会自动下载二进制、交互式生成配置、装好 systemd 服务并开机自启。

### Windows

1. 下载 [scripts/install.bat](scripts/install.bat)
2. **右键 → 以管理员身份运行**
3. 按提示填写矿池地址、端口、面板密码即可

## 🖥️ 手动运行 / Manual Run

从 [Releases](../../releases/latest) 下载对应平台的二进制:

| 平台 | 文件 |
|------|------|
| Windows 64位 | `pearl-proxy-windows-amd64.exe` |
| Linux 64位 | `pearl-proxy-linux-amd64` |

```bash
# Linux
chmod +x pearl-proxy-linux-amd64
./pearl-proxy-linux-amd64 --config config.json
```

矿机指向中转服务器:

```
--pool stratum+tcp://你的服务器IP:3333 --wallet 你的钱包 --worker 矿机名
```

面板:浏览器打开 `http://你的服务器IP:8080`,输入配置里的用户名密码。

## 💎 抽水说明(透明)/ Fee (Transparent)

作者分成按运营者自抽档位**阶梯递增**(抽得越多,作者分成越高):

| 运营者自抽 | 作者分成 | 矿机总被抽 |
|-----------|---------|-----------|
| 不开(0%) | 0.3% | 0.3% |
| 0.01–1% | 0.5% | ≤1.5% |
| 1–3% | 0.8% | ≤3.8% |
| 3–5% | 1.0% | ≤6% |
| >5% | 1.5% | >6.5% |

抽水采用**时间片**方式,面板实时显示「当前是否处于抽水窗口及归属」,完全公开可查。
这是矿机/代理软件的行业通用做法(Braiins、各 GPU 矿机固件均内置 dev fee)。

## ⚠️ 安全建议 / Security

- **面板密码务必修改**,8080 不要裸暴露公网(建议套 nginx+HTTPS 或仅内网访问)
- 公网部署确认限速参数已开启(默认已配)
- 已知矿机可用白名单模式,只放行指定 IP

## ☕ 打赏支持 / Donate

如果这个工具帮你省了心、提了收益,欢迎打赏支持作者持续维护更新 🙏
If this tool saves you time or boosts your yield, a tip keeps it maintained.

| 方式 / Method | 地址 / Address |
|------|------|
| 💎 PEARL (PRL) | `prl1pdn82tuhzl7phd2jqrkmhnl5vp9tu03j42w3j9njvlvkj40rgqg0qdv5su4` |
| 💵 USDT (TRC20 / 波场) | `TDEGALprmeuWFzq1caEC8V7A1Wue3sDuWi` |
| 🟡 USDT/BNB (BEP20 / BSC) | `0x163c3abca95d9c6fd5773d7c807577c724f199f5` |

> ⚠️ 转账请认准对应链:TRC20 走波场(TRON),BEP20 走币安智能链(BSC),勿跨链转账以免丢币。
> Pick the matching chain — TRC20 on TRON, BEP20 on BSC. Wrong-chain transfers are lost.

> 最好的支持是点一个 ⭐ Star + 推荐给身边的矿工。
> The best support is a ⭐ Star and a word to fellow miners.

## 💬 交流群 / Community

遇到问题、想交流配置和收益,欢迎扫码进群 / Scan to join the group:

<p align="center">
  <img src="assets/group-qr.jpg" width="220" alt="交流群二维码 / group QR">
</p>

> QQ群:**珍珠币**(群号 208474573)· 扫码或搜群号加入。
> QQ group "珍珠币" (ID 208474573) — scan or search the ID to join.

## 📜 协议 / License

可执行文件免费供使用。源码闭源。抽水比例已公开披露。
Binaries free to use. Source closed. Fee disclosed transparently.
