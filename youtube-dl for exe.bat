@echo off&
echo.
echo ##### 请放在youtube-dl目录下运行 #####
echo.
if exist "%~dp0\youtube-dl.exe" ( echo 已在youtube-dl目录下，欢迎使用 ) else ( echo 请放在youtube-dl目录下运行！ )
:start
set a=
set b=
echo.
set /p a=请输入视频地址:
echo.
if "%a%"=="" (
goto :start
) else (
youtube-dl --list-formats "%a%"
)
echo.
echo.
set /p b=请输入您要下载的分段，留空将返回第一步:
echo.
if "%b%"=="" (
goto :start
) else (
youtube-dl -f "%b%" "%a%"
)
echo 当前下载完成，如下载中断，重新输入即可续传

pause
goto start