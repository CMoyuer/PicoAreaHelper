@echo off

:Retry
cls
echo ===================================================
echo PICO�����л�����
echo �汾��1.0.2
echo By������Nya
set adb=%~dp0\ADB\adb.exe
%adb% devices -l | findstr "PICO">nul && (goto Success)
echo ===================================================
echo �Ҳ���PICO�豸�����������������Ƿ��������豸�Ƿ��Ѵ򿪿�����ģʽ��
pause
cls
goto Retry

:Success
echo ===================================================
echo ׼���л��豸���򵽣�ȫ��
echo ��ȷ�������в�Ҫ�ε�������
echo ������ɺ��豸���Զ���������������
echo ===================================================
pause
echo �����豸����...
%adb% shell settings put global user_settings_initialized HK
echo Success
echo ���Ӧ�û��棨1/2��...
%adb% shell pm clear com.picovr.store
echo ���Ӧ�û��棨2/2��...
%adb% shell pm clear com.picovr.vrusercenter
echo ��װ����Ӧ��...
for %%i in (%~dp0\Apks\Global\*.apk) do (
 	ECHO ���ڰ�װ��%%i
 	%adb% install -r -d "%%i"
)
echo ���������豸...
%adb% reboot
echo ִ����ϣ�
echo ===================================================
pause
