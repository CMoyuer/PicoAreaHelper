@echo off

:Retry
cls
echo ===================================================
echo PICO区域切换助手
echo 版本：1.0.2
echo By：如梦Nya
set adb=%~dp0\ADB\adb.exe
%adb% devices -l | findstr "PICO">nul && (goto Success)
echo ===================================================
echo 找不到PICO设备，请检查数据线连接是否正常，设备是否已打开开发者模式！
pause
cls
goto Retry

:Success
echo ===================================================
echo 准备切换设备区域到：全球
echo 请确保过程中不要拔掉数据线
echo 设置完成后设备会自动重启，敬请留意
echo ===================================================
pause
echo 更改设备区域...
%adb% shell settings put global user_settings_initialized HK
echo Success
echo 清除应用缓存（1/2）...
%adb% shell pm clear com.picovr.store
echo 清除应用缓存（2/2）...
%adb% shell pm clear com.picovr.vrusercenter
echo 安装所需应用...
for %%i in (%~dp0\Apks\Global\*.apk) do (
 	ECHO 正在安装：%%i
 	%adb% install -r -d "%%i"
)
echo 正在重启设备...
%adb% reboot
echo 执行完毕！
echo ===================================================
pause
