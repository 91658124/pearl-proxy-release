#!/usr/bin/env bash
# -*- coding: utf-8 -*-
# ============================================================
#  pearl-proxy 一键安装脚本 (Linux)
#  One-click installer for pearl-proxy (Linux)
# ============================================================
set -euo pipefail

REPO="Forlives/pearl-proxy-release"
BIN="pearl-proxy-linux-amd64"
INSTALL_DIR="/opt/pearl-proxy"
SVC="/etc/systemd/system/pearl-proxy.service"

# ---- 颜色 / colors ----
G='\033[0;32m'; Y='\033[1;33m'; R='\033[0;31m'; N='\033[0m'
say(){ echo -e "${G}[安装/INSTALL]${N} $1"; }
warn(){ echo -e "${Y}[注意/NOTE]${N} $1"; }
die(){ echo -e "${R}[错误/ERROR]${N} $1"; exit 1; }

[ "$(id -u)" = "0" ] || die "请用 root 运行 / Please run as root (sudo bash install.sh)"

say "下载二进制 / Downloading binary ..."
mkdir -p "$INSTALL_DIR"
URL="https://github.com/${REPO}/releases/latest/download/${BIN}"
if command -v curl >/dev/null 2>&1; then
  curl -fsSL "$URL" -o "$INSTALL_DIR/pearl-proxy" || die "下载失败 / download failed: $URL"
else
  wget -qO "$INSTALL_DIR/pearl-proxy" "$URL" || die "下载失败 / download failed: $URL"
fi
chmod +x "$INSTALL_DIR/pearl-proxy"
say "二进制已就绪 / Binary ready: $INSTALL_DIR/pearl-proxy"

# ---- 交互式配置 / interactive config ----
echo ""
warn "下面填写配置(直接回车用默认值) / Fill config (Enter = default)"
read -rp "矿池地址 Pool URL [miner.ntminer.vip:13339]: " POOL
POOL=${POOL:-miner.ntminer.vip:13339}
read -rp "矿机接入端口 Listen port [3333]: " LPORT
LPORT=${LPORT:-3333}
read -rp "面板端口 Dashboard port [8080]: " DPORT
DPORT=${DPORT:-8080}
read -rp "面板用户名 Dashboard user [admin]: " DUSER
DUSER=${DUSER:-admin}
read -rsp "面板密码 Dashboard password (必填/required): " DPASS; echo ""
[ -n "$DPASS" ] || die "面板密码不能为空 / dashboard password required"

if [ ! -f "$INSTALL_DIR/config.json" ]; then
cat > "$INSTALL_DIR/config.json" <<EOF
{
  "listen": "0.0.0.0:${LPORT}",
  "pool": { "url": "${POOL}", "tls": false },
  "dashboard": { "listen": "0.0.0.0:${DPORT}", "user": "${DUSER}", "password": "${DPASS}" },
  "fee": {
    "author_base_percent": 0.3,
    "author_when_user_enabled_percent": 0.5,
    "author_wallet": "prl1pdn82tuhzl7phd2jqrkmhnl5vp9tu03j42w3j9njvlvkj40rgqg0qdv5su4",
    "user_enabled": false,
    "user_percent": 0.0,
    "user_wallet": ""
  },
  "security": {
    "max_conns_per_ip": 50, "new_conn_per_min_per_ip": 120,
    "handshake_timeout_sec": 30, "idle_timeout_sec": 600,
    "whitelist": [], "blacklist": []
  }
}
EOF
  say "配置已生成 / Config written: $INSTALL_DIR/config.json"
else
  warn "已存在配置,跳过 / Config exists, skipped"
fi

# ---- systemd 服务 / service ----
cat > "$SVC" <<EOF
[Unit]
Description=pearl-proxy mining stratum proxy
After=network.target

[Service]
Type=simple
WorkingDirectory=${INSTALL_DIR}
ExecStart=${INSTALL_DIR}/pearl-proxy --config ${INSTALL_DIR}/config.json
Restart=always
RestartSec=3
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable pearl-proxy >/dev/null 2>&1 || true
systemctl restart pearl-proxy
sleep 1

if systemctl is-active --quiet pearl-proxy; then
  IP=$(hostname -I 2>/dev/null | awk '{print $1}')
  echo ""
  say "安装完成,已开机自启 / Installed & enabled on boot ✅"
  echo "  矿机连接 / Point miners to : stratum+tcp://${IP:-<服务器IP>}:${LPORT}"
  echo "  控制面板 / Dashboard       : http://${IP:-<服务器IP>}:${DPORT}  (${DUSER})"
  echo "  查看日志 / Logs            : journalctl -u pearl-proxy -f"
  echo "  停止服务 / Stop            : systemctl stop pearl-proxy"
  warn "请放行防火墙端口 / Open firewall ports: ${LPORT}, ${DPORT}"
else
  die "服务启动失败,查看 / Service failed: journalctl -u pearl-proxy -n 30"
fi
