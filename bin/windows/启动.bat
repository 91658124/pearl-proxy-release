@echo off
chcp 65001 >nul
REM pearl-proxy 一键启动 (Windows) — clone 仓库后双击本文件
cd /d "%~dp0"
if not exist config.json (
  echo 缺 config.json
  pause
  exit /b 1
)
echo 启动 pearl-proxy ^(矿机接入 3333, 面板 127.0.0.1:8080^)
echo 请先编辑 config.json 把 dashboard.password 改掉
pearl-proxy.exe --config config.json
pause
