@echo off&
echo.
echo ##### �����youtube-dlĿ¼������ #####
echo.
if exist "%~dp0\youtube-dl.exe" ( echo ����youtube-dlĿ¼�£���ӭʹ�� ) else ( echo �����youtube-dlĿ¼�����У� )
:start
set a=
set b=
echo.
set /p a=��������Ƶ��ַ:
echo.
if "%a%"=="" (
goto :start
) else (
youtube-dl --list-formats "%a%"
)
echo.
echo.
set /p b=��������Ҫ���صķֶΣ����ս����ص�һ��:
echo.
if "%b%"=="" (
goto :start
) else (
youtube-dl -f "%b%" "%a%"
)
echo ��ǰ������ɣ��������жϣ��������뼴������

pause
goto start