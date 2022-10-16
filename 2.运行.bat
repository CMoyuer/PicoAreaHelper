@echo off

:Retry
cls
echo ===================================================
echo PICO�����л�����
echo �汾��0.3
echo By������Nya
set adb=%~dp0\ADB\adb.exe
%adb% devices -l | findstr "PICO">nul && (goto Success) || (goto Fail)
pause

:Success
echo ===================================================
echo ��ܰ��ʾ��ÿ�λ������������һ�Σ��Է�����������֢����
echo ===================================================
echo �����嵥
echo 0.����������
echo 1.�л��豸����Ϊ�й�
echo 2.�л��豸����Ϊ����
echo 3.�����豸
echo ===================================================
set mode=-1
set /p mode=��������Ҫִ�еĹ���ID��
if "%mode%" == "0" goto OpenFactoryTest
if "%mode%" == "1" goto SwitchChina
if "%mode%" == "2" goto SwitchOther
if "%mode%" == "3" goto Reboot
echo ����������������������ID��
pause
cls
goto Success

:Fail
echo ===================================================
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
echo ===================================================
goto ConfirmReboot

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
echo ת����ɣ�
echo ===================================================
goto ConfirmReboot

:ConfirmReboot
echo ������������Է�����������֢���֣�
set flag=-1
set /p flag=�Ƿ����������豸����Y/N��
if "%flag%" == "y" goto Reboot
if "%flag%" == "Y" goto Reboot
if "%flag%" == "n" goto CancelReboot
if "%flag%" == "N" goto CancelReboot
echo ����������������룡
goto ConfirmReboot

:CancelReboot
echo ���Ժ��ֶ������豸�����ⷢ���쳣�����
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