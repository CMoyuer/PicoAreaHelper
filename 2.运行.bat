@echo off

:Retry
cls
echo ===================================================
echo PICO区域切换助手
echo 版本：0.2
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
echo 3.重启设备
echo ===================================================
echo 请输入你要执行的功能ID：
set /p mode=%1%
if %mode% == 0 goto OpenFactoryTest
if %mode% == 1 goto SwitchChina
if %mode% == 2 goto SwitchOther
if %mode% == 3 goto Reboot
cls
echo 参数错误，请重新输入数字ID！
goto Success

:Fail
echo 找不到PICO设备，请检查数据线连接是否正常，设备是否已打开开发者模式！
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
%adb% shell pm clear com.picovr.vrusercenter
%adb% shell pm clear com.bytedance.pico.matrix
echo 删除不需要的应用...
%adb% uninstall com.bytedance.pico.matrix
echo 安装所需应用...
for %%i in (%~dp0\Apks\China\*.apk) do (
 	ECHO 正在安装：%%i
 	%adb% install -r -d "%%i"
)
echo 转区完成！
echo 如果打不开登录界面，请尝试重启设备~
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
%adb% shell pm clear com.picovr.vrusercenter
echo 安装所需应用...
for %%i in (%~dp0\Apks\Other\*.apk) do (
 	ECHO 正在安装：%%i
 	%adb% install -r -d "%%i"
)
echo 执行完成！
echo ===================================================
goto End

:Reboot
%adb% reboot
echo ===================================================
echo 执行完成！
goto End

:End
pause
cls
goto Retry