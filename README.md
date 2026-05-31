# pearl-proxy · 珍珠币(PEARL/PRL)矿池中转加速器

<p align="center">
  <a href="https://github.com/Forlives/pearl-proxy-release/stargazers"><img src="https://img.shields.io/github/stars/Forlives/pearl-proxy-release?style=flat-square&logo=github&label=Star%20点星" alt="stars"></a>
  <a href="https://github.com/Forlives/pearl-proxy-release/releases/latest"><img src="https://img.shields.io/github/v/release/Forlives/pearl-proxy-release?style=flat-square&label=最新版本" alt="release"></a>
  <a href="https://github.com/Forlives/pearl-proxy-release/releases"><img src="https://img.shields.io/github/downloads/Forlives/pearl-proxy-release/total?style=flat-square&label=下载量" alt="downloads"></a>
  <img src="https://img.shields.io/badge/平台-Windows%20%7C%20Linux-blue?style=flat-square" alt="platform">
  <img src="https://img.shields.io/badge/语言-Go-00ADD8?style=flat-square&logo=go" alt="go">
</p>

> ⭐ 觉得好用请点个 Star,让更多矿工看到 / If it helps, please **Star** the repo!
>
> 这是**发布仓库**,只提供编译好的可执行文件、一键安装脚本和使用说明。
> This is the **release repo** — prebuilt binaries, one-click installers, and usage docs only.

部署在中转服务器上,矿机连你的服务器、服务器复用长连接到矿池:**降低延迟、自动断线重连、统一可视化看板**,让你为下游矿工提供加速服务。

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
| 💵 USDT (TRC20) | `在此粘贴你的USDT-TRC20地址 / PASTE-YOUR-USDT-TRC20-ADDRESS` |

<a href="https://www.buymeacoffee.com/"><img src="https://img.shields.io/badge/Buy%20Me%20A%20Coffee-请我喝咖啡-FFDD00?style=for-the-badge&logo=buy-me-a-coffee&logoColor=black" alt="buy me a coffee"></a>

> 最好的支持是点一个 ⭐ Star + 推荐给身边的矿工。
> The best support is a ⭐ Star and a word to fellow miners.

## 💬 交流群 / Community

遇到问题、想交流配置和收益,欢迎扫码进群 / Scan to join the group:

<p align="center">
  <img src="assets/group-qr.jpg" width="220" alt="交流群二维码 / group QR">
</p>

> QQ群:**珍珠币**(群号 208474573)· 扫码或搜群号加入。
> QQ group "珍珠币" (ID 208474573) — scan or search the ID to join.

## 📈 Star 趋势 / Star History

[![Star History Chart](https://api.star-history.com/svg?repos=Forlives/pearl-proxy-release&type=Date)](https://star-history.com/#Forlives/pearl-proxy-release&Date)

## 📜 协议 / License

可执行文件免费供使用。源码闭源。抽水比例已公开披露。
Binaries free to use. Source closed. Fee disclosed transparently.
