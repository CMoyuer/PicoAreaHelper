@echo off
chcp 65001
%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit
cls
pnputil /add-driver %~dp0\usb_driver\android_winusb.inf
echo 执行完成
pause