#!/usr/bin/env bash
# pearl-proxy 一键启动 (Linux) — clone 仓库后直接 ./start.sh
cd "$(dirname "$0")"
chmod +x ./pearl-proxy 2>/dev/null
if [ ! -f config.json ]; then echo "缺 config.json"; exit 1; fi
echo "启动 pearl-proxy (矿机接入 3333, 面板 127.0.0.1:8080)"
echo "请先编辑 config.json 把 dashboard.password 改掉"
exec ./pearl-proxy --config config.json
