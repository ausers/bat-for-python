@echo off&
echo.
echo ##### 请放在akamTester目录下运行 #####
echo.
if exist "%~dp0\akamTester.py" ( echo 已在akamTester目录下，欢迎使用 ) else ( echo 请放在akamTester目录下运行！ )
:start
echo ====================================
echo 1：开始测试（默认测试域名upos-hz-mirrorakam.akamaized.net）
echo 2：开始测试（自定义测试域名）
echo 3：默认测试并写入hosts（需要管理员权限）
echo 4：自定义测试并写入hosts（需要管理员权限）
echo ====================================
echo 请选择：
choice /c 1234
if %errorlevel%==4 (goto :test4)
if %errorlevel%==3 (goto :test3)
if %errorlevel%==2 (goto :test2)
if %errorlevel%==1 (goto :test1)

:test1
echo.|python %~dp0\akamTester.py
pause >nul
goto :start

:test2
set /p a=请输入您的指定测试域名:
echo.|python %~dp0\akamTester.py -u "%a%"
pause >nul
goto :start

:test3
if exist "%SystemRoot%\SysWOW64" path %path%;%windir%\SysNative;%SystemRoot%\SysWOW64;%~dp0
bcdedit >nul
if '%errorlevel%' NEQ '0' (echo 当前无管理员权限，无法写入hosts，转向指令1 && goto test1) else (echo 当前已获取管理员权限)
echo.|python %~dp0\akamTester.py>%~dp0\results.txt
for /f "tokens=2 skip=13 delims= " %%i in (%~dp0\results.txt) do set /a num=%%i+17 &goto ip1
:ip1
for /f "eol=按 tokens=1,3 skip=%num%" %%i in (%~dp0\results.txt) do echo %%i %%j>>%~dp0\temp.txt
find /v "" /c %~dp0\temp.txt >%~dp0\log.txt
for /f "tokens=3 skip=1 delims= " %%i in (%~dp0\log.txt) do set lines=%%i
for /f "tokens=2" %%i in (%~dp0\temp.txt) do echo %%i>>%~dp0\results2.txt
sort %~dp0\results2.txt >%~dp0\sort.txt
set /p a=<%~dp0\sort.txt
find /i "%a%" "%~dp0\temp.txt" >%~dp0\temp2.txt
for /f "tokens=1" %%i in (%~dp0\temp2.txt) do set ip=%%i
findstr /v "#哔哩哔哩海外CDN" "C:\Windows\System32\drivers\etc\hosts">C:\Windows\System32\drivers\etc\hosts2
xcopy /y /c /h /r "C:\Windows\System32\drivers\etc\hosts2" "C:\Windows\System32\drivers\etc\hosts" > nul
echo %ip% upos-hz-mirrorakam.akamaized.net #哔哩哔哩海外CDN>>C:\Windows\System32\drivers\etc\hosts
set /a num2=%num%-1
for /f "eol=按 skip=%num2% delims=" %%i in (%~dp0\results.txt) do echo %%i>>%~dp0\results3.txt
type %~dp0\results3.txt
del %~dp0\temp.txt %~dp0\temp2.txt %~dp0\sort.txt %~dp0\results2.txt %~dp0\log.txt %~dp0\results3.txt
pause
goto :start

:test4
if exist "%SystemRoot%\SysWOW64" path %path%;%windir%\SysNative;%SystemRoot%\SysWOW64;%~dp0
bcdedit >nul
if '%errorlevel%' NEQ '0' (echo 当前无管理员权限，无法写入hosts，转向指令2 && goto test2) else (echo 当前已获取管理员权限)
set /p url=请输入您的指定测试域名:
if "%url%"=="" (
set url=upos-hz-mirrorakam.akamaized.net &goto :jx
) else (
goto :jx
)
:jx
echo.|python %~dp0\akamTester.py -u "%url%"
for /f "tokens=2 skip=13 delims= " %%i in (%~dp0\%url%.txt) do set /a num=%%i+17 &goto ip2
:ip2
for /f "eol=按 tokens=1,3 skip=%num%" %%i in (%~dp0\%url%.txt) do echo %%i %%j>>%~dp0\temp.txt
find /v "" /c %~dp0\temp.txt >%~dp0\log.txt
for /f "tokens=3 skip=1 delims= " %%i in (%~dp0\log.txt) do set lines=%%i
for /f "tokens=2" %%i in (%~dp0\temp.txt) do echo %%i>>%~dp0\results2.txt
sort %~dp0\results2.txt >%~dp0\sort.txt
set /p a=<%~dp0\sort.txt
find /i "%a%" "%~dp0\temp.txt" >%~dp0\temp2.txt
for /f "tokens=1" %%i in (%~dp0\temp2.txt) do set ip=%%i
findstr /v "#URL测试%url%" "C:\Windows\System32\drivers\etc\hosts">C:\Windows\System32\drivers\etc\hosts2
xcopy /y /c /h /r "C:\Windows\System32\drivers\etc\hosts2" "C:\Windows\System32\drivers\etc\hosts" > nul
echo %ip% %url% #URL测试%url%>>C:\Windows\System32\drivers\etc\hosts
set /a num2=%num%-1
for /f "eol=按 skip=%num2% delims=" %%i in (%~dp0\%url%.txt) do echo %%i>>%~dp0\results3.txt
type %~dp0\%url%.txt
del %~dp0\temp.txt %~dp0\temp2.txt %~dp0\sort.txt %~dp0\results2.txt %~dp0\log.txt %~dp0\results3.txt
pause
goto :start