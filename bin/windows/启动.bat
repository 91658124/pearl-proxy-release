@echo off
chcp 65001 >nul
cd /d "%~dp0"
echo ============================================
echo   pearl-proxy 矿池中转加速器 · 启动中
echo ============================================
echo.
echo   矿机连接地址 / Point miners to : stratum+tcp://本机IP:3333
echo   Web 管理面板 / Dashboard       : http://本机IP:8080
echo   默认账号 admin,密码见 config.json
echo.
echo   关闭此窗口即停止服务。
echo ============================================
echo.
pearl-proxy.exe --config config.json
pause
