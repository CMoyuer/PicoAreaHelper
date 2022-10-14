@echo off
chcp 65001

:Retry
cls
echo ===================================================
echo PICO区域切换助手 
echo 版本：0.1 
echo By：如梦Nya 
echo ===================================================
set adb=%~dp0\ADB\adb.exe
%adb% devices -l | findstr "PICO">nul && (goto Success) || (goto Fail)
pause

:Success
echo ===================================================
echo 功能清单 
echo 0.打开区域设置 
echo 1.切换设备区域为中国 
echo 2.切换设备区域为海外 
echo ===================================================
echo 请输入你要执行的功能ID： 
set /p mode=%1%
if %mode% == 0 goto OpenFactoryTest
if %mode% == 1 goto SwitchChina
if %mode% == 2 goto SwitchOther
cls
echo 参数错误，请重新输入数字ID！ 
goto Success

:Fail
echo 找不到PICO设备，请检查数据线连接是否正常，设备是否已打开开发者模式！ 
echo 输入任意键重试... 
pause
cls
goto Retry

:OpenFactoryTest
%adb% shell am start -n com.picovr.factorytest/com.picovr.factorytest.setting.PicoSettingMainActivity >nul
echo ===================================================
echo 执行完成！ 
echo 带上VR眼镜看看吧！ 
goto End

:SwitchChina
echo ===================================================
echo 准备切换至：中国 
echo 请确保过程中不要拔掉数据线，输入任意键继续 
pause
echo ===================================================
echo 清除应用缓存... 
%adb% shell pm clear com.picovr.store
echo 清除应用缓存... 
%adb% shell pm clear com.picovr.vrusercenter
echo 安装应用商店... 
%adb% install -r -d %~dp0\Apks\China\com.picovr.store_3.2.1.apk
echo 安装用户中心... 
%adb% install -r -d  %~dp0\Apks\China\com.picovr.vrusercenter_1.3.7.apk
echo 执行完成！ 
echo ===================================================
goto End

:SwitchOther
echo ===================================================
echo 准备切换至：海外 
echo 请确保过程中不要拔掉数据线，输入任意键继续 
pause
echo ===================================================
echo 清除应用缓存... 
%adb% shell pm clear com.picovr.store
echo 清除应用缓存... 
%adb% shell pm clear com.picovr.vrusercenter
echo 安装应用商店... 
%adb% install -r -d %~dp0\Apks\Other\com.picovr.store_3.3.0.apk
echo 安装用户中心... 
%adb% install -r -d %~dp0\Apks\Other\com.picovr.vrusercenter_2.0.5.apk
echo 执行完成！ 
echo ===================================================
goto End

:End
pause
cls
goto Retry