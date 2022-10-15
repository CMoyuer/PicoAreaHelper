@echo off

:Retry
cls
echo ===================================================
echo PICO�����л����� 
echo �汾��0.1.1 
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
echo ===================================================
echo ��������Ҫִ�еĹ���ID�� 
set /p mode=%1%
if %mode% == 0 goto OpenFactoryTest
if %mode% == 1 goto SwitchChina
if %mode% == 2 goto SwitchOther
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
echo ���Ӧ�û���... 
%adb% shell pm clear com.picovr.vrusercenter
echo ��װӦ���̵�... 
%adb% install -r -d %~dp0\Apks\China\com.picovr.store_3.2.1.apk
echo ��װ�û�����... 
%adb% install -r -d  %~dp0\Apks\China\com.picovr.vrusercenter_1.3.7.apk
echo ִ����ɣ� 
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
echo ���Ӧ�û���... 
%adb% shell pm clear com.picovr.vrusercenter
echo ��װӦ���̵�... 
%adb% install -r -d %~dp0\Apks\Other\com.picovr.store_3.3.0.apk
echo ��װ�û�����... 
%adb% install -r -d %~dp0\Apks\Other\com.picovr.vrusercenter_2.0.5.apk
echo ִ����ɣ� 
echo ===================================================
goto End

:End
pause
cls
goto Retry