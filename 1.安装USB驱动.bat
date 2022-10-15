@echo off
%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit
cls
pnputil /add-driver %~dp0\usb_driver\*.inf
echo ===================================================
echo Ö´ÐÐÍê³É
pause