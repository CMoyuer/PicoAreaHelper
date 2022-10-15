@echo off

:Retry
cls
echo ===================================================
echo PICO�����л�����
echo �汾��0.2
echo By������Nya
echo ===================================================
set adb=%~dp0\ADB\adb.exe
%adb% devices -l | findstr "PICO">nul && (goto Success) || (goto Fail)
pause

:Success
echo ===================================================
echo �����嵥
echo 0.����������
echo 1.�л��豸����Ϊ�й�
echo 2.�л��豸����Ϊ����
echo 3.�����豸
echo ===================================================
echo ��������Ҫִ�еĹ���ID��
set /p mode=%1%
if %mode% == 0 goto OpenFactoryTest
if %mode% == 1 goto SwitchChina
if %mode% == 2 goto SwitchOther
if %mode% == 3 goto Reboot
cls
echo ����������������������ID��
goto Success

:Fail
echo �Ҳ���PICO�豸�����������������Ƿ��������豸�Ƿ��Ѵ򿪿�����ģʽ��
pause
cls
goto Retry

:OpenFactoryTest
%adb% shell am start -n com.picovr.factorytest/com.picovr.factorytest.setting.PicoSettingMainActivity >nul
echo ===================================================
echo ִ����ɣ�
echo ����VR�۾������ɣ�
goto End

:SwitchChina
echo ===================================================
echo ׼���л������й�
echo ��ȷ�������в�Ҫ�ε������ߣ��������������
pause
echo ===================================================
echo ���Ӧ�û���...
%adb% shell pm clear com.picovr.store
%adb% shell pm clear com.picovr.vrusercenter
%adb% shell pm clear com.bytedance.pico.matrix
echo ɾ������Ҫ��Ӧ��...
%adb% uninstall com.bytedance.pico.matrix
echo ��װ����Ӧ��...
for %%i in (%~dp0\Apks\China\*.apk) do (
 	ECHO ���ڰ�װ��%%i
 	%adb% install -r -d "%%i"
)
echo ת����ɣ�
echo ����򲻿���¼���棬�볢�������豸~
echo ===================================================
goto End

:SwitchOther
echo ===================================================
echo ׼���л���������
echo ��ȷ�������в�Ҫ�ε������ߣ��������������
pause
echo ===================================================
echo ���Ӧ�û���...
%adb% shell pm clear com.picovr.store
%adb% shell pm clear com.picovr.vrusercenter
echo ��װ����Ӧ��...
for %%i in (%~dp0\Apks\Other\*.apk) do (
 	ECHO ���ڰ�װ��%%i
 	%adb% install -r -d "%%i"
)
echo ִ����ɣ�
echo ===================================================
goto End

:Reboot
%adb% reboot
echo ===================================================
echo ִ����ɣ�
goto End

:End
pause
cls
goto Retry