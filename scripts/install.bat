@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion
REM ============================================================
REM  pearl-proxy 一键安装脚本 (Windows)
REM  One-click installer for pearl-proxy (Windows)
REM ============================================================

set "REPO=Forlives/pearl-proxy-release"
set "BIN=pearl-proxy-windows-amd64.exe"
set "INSTALL_DIR=%~dp0pearl-proxy"
set "URL=https://github.com/%REPO%/releases/latest/download/%BIN%"

echo.
echo ============================================================
echo   pearl-proxy 矿池中转加速器 · 一键安装
echo   pearl-proxy mining proxy - one-click installer
echo ============================================================
echo.

if not exist "%INSTALL_DIR%" mkdir "%INSTALL_DIR%"

echo [下载/DOWNLOAD] 正在下载二进制 / Downloading binary ...
echo   %URL%
powershell -Command "try { Invoke-WebRequest -Uri '%URL%' -OutFile '%INSTALL_DIR%\pearl-proxy.exe' -UseBasicParsing } catch { exit 1 }"
if errorlevel 1 (
  echo [错误/ERROR] 下载失败 / Download failed. 检查网络或手动从 Release 下载。
  pause
  exit /b 1
)
echo [完成/OK] 二进制已就绪 / Binary ready: %INSTALL_DIR%\pearl-proxy.exe
echo.

REM ---- 交互式配置 / interactive config ----
echo [配置/CONFIG] 直接回车用默认值 / Enter = default
set "POOL=miner.ntminer.vip:13339"
set /p "POOL=矿池地址 Pool URL [%POOL%]: "
set "LPORT=3333"
set /p "LPORT=矿机接入端口 Listen port [%LPORT%]: "
set "DPORT=8080"
set /p "DPORT=面板端口 Dashboard port [%DPORT%]: "
set "DUSER=admin"
set /p "DUSER=面板用户名 Dashboard user [%DUSER%]: "
set "DPASS="
set /p "DPASS=面板密码 Dashboard password (必填/required): "
if "%DPASS%"=="" (
  echo [错误/ERROR] 面板密码不能为空 / Password required.
  pause
  exit /b 1
)

if exist "%INSTALL_DIR%\config.json" (
  echo [注意/NOTE] 已存在配置,跳过 / Config exists, skipped.
  goto :run
)

REM ---- 写配置文件 / write config (用PowerShell写UTF-8,避免bat转义坑) ----
powershell -Command ^
 "$c = @{ listen='0.0.0.0:%LPORT%'; pool=@{url='%POOL%';tls=$false};" ^
 " dashboard=@{listen='127.0.0.1:%DPORT%';user='%DUSER%';password='%DPASS%'};" ^
 " fee=@{user_enabled=$false; user_percent=0.0; user_wallet=''};" ^
 " security=@{max_conns_per_ip=50; new_conn_per_min_per_ip=120;" ^
 "  handshake_timeout_sec=30; idle_timeout_sec=600; whitelist=@(); blacklist=@()} };" ^
 " $c | ConvertTo-Json -Depth 6 | Set-Content -Encoding UTF8 '%INSTALL_DIR%\config.json'"
echo [完成/OK] 配置已生成 / Config written: %INSTALL_DIR%\config.json

:run
echo.
echo [启动/START] 正在启动中转站 / Starting proxy ...
cd /d "%INSTALL_DIR%"
start "pearl-proxy" /min "%INSTALL_DIR%\pearl-proxy.exe" --config "%INSTALL_DIR%\config.json"
timeout /t 2 >nul

echo.
echo ============================================================
echo   安装完成 / Installed  ✅
echo ============================================================
echo   矿机连接 / Point miners to : stratum+tcp://本机IP:%LPORT%
echo   控制面板 / Dashboard       : http://127.0.0.1:%DPORT%   (%DUSER%)  仅本机/localhost-only
echo   停止 / Stop                : 任务管理器结束 pearl-proxy.exe
echo.
echo [注意/NOTE] 请在防火墙/安全组放行矿机端口 / Open miner port: %LPORT%
echo [注意/NOTE] 面板仅本机可访问;想开机自启可把启动命令加入计划任务。
echo.
pause
