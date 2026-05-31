#!/usr/bin/env bash
# pearl-proxy 启动脚本 / start script (Linux)
cd "$(dirname "$0")"
chmod +x pearl-proxy 2>/dev/null
echo "============================================================"
echo " pearl-proxy 矿池中转加速器 启动中 / starting..."
echo " 矿机连接 / Point miners to : stratum+tcp://本机IP:3333"
echo " Web控制台 / Dashboard       : http://本机IP:8080  (admin)"
echo " 面板密码见 config.json / dashboard password in config.json"
echo " 按 Ctrl+C 停止 / Ctrl+C to stop"
echo "============================================================"
exec ./pearl-proxy --config config.json
