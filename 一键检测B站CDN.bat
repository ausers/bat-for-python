@echo off&
echo.
echo ##### �����akamTesterĿ¼������ #####
echo.
if exist "%~dp0\akamTester.py" ( echo ����akamTesterĿ¼�£���ӭʹ�� ) else ( echo �����akamTesterĿ¼�����У� )
:start
echo ====================================
echo 1����ʼ���ԣ�Ĭ�ϲ�������upos-hz-mirrorakam.akamaized.net��
echo 2����ʼ���ԣ��Զ������������
echo 3��Ĭ�ϲ��Բ�д��hosts����Ҫ����ԱȨ�ޣ�
echo 4���Զ�����Բ�д��hosts����Ҫ����ԱȨ�ޣ�
echo ====================================
echo ��ѡ��
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
set /p a=����������ָ����������:
echo.|python %~dp0\akamTester.py -u "%a%"
pause >nul
goto :start

:test3
if exist "%SystemRoot%\SysWOW64" path %path%;%windir%\SysNative;%SystemRoot%\SysWOW64;%~dp0
bcdedit >nul
if '%errorlevel%' NEQ '0' (echo ��ǰ�޹���ԱȨ�ޣ��޷�д��hosts��ת��ָ��1 && goto test1) else (echo ��ǰ�ѻ�ȡ����ԱȨ��)
echo.|python %~dp0\akamTester.py>%~dp0\results.txt
for /f "tokens=2 skip=13 delims= " %%i in (%~dp0\results.txt) do set /a num=%%i+17 &goto ip1
:ip1
for /f "eol=�� tokens=1,3 skip=%num%" %%i in (%~dp0\results.txt) do echo %%i %%j>>%~dp0\temp.txt
find /v "" /c %~dp0\temp.txt >%~dp0\log.txt
for /f "tokens=3 skip=1 delims= " %%i in (%~dp0\log.txt) do set lines=%%i
for /f "tokens=2" %%i in (%~dp0\temp.txt) do echo %%i>>%~dp0\results2.txt
sort %~dp0\results2.txt >%~dp0\sort.txt
set /p a=<%~dp0\sort.txt
find /i "%a%" "%~dp0\temp.txt" >%~dp0\temp2.txt
for /f "tokens=1" %%i in (%~dp0\temp2.txt) do set ip=%%i
findstr /v "#������������CDN" "C:\Windows\System32\drivers\etc\hosts">C:\Windows\System32\drivers\etc\hosts2
xcopy /y /c /h /r "C:\Windows\System32\drivers\etc\hosts2" "C:\Windows\System32\drivers\etc\hosts" > nul
echo %ip% upos-hz-mirrorakam.akamaized.net #������������CDN>>C:\Windows\System32\drivers\etc\hosts
set /a num2=%num%-1
for /f "eol=�� skip=%num2% delims=" %%i in (%~dp0\results.txt) do echo %%i>>%~dp0\results3.txt
type %~dp0\results3.txt
del %~dp0\temp.txt %~dp0\temp2.txt %~dp0\sort.txt %~dp0\results2.txt %~dp0\log.txt %~dp0\results3.txt
pause
goto :start

:test4
if exist "%SystemRoot%\SysWOW64" path %path%;%windir%\SysNative;%SystemRoot%\SysWOW64;%~dp0
bcdedit >nul
if '%errorlevel%' NEQ '0' (echo ��ǰ�޹���ԱȨ�ޣ��޷�д��hosts��ת��ָ��2 && goto test2) else (echo ��ǰ�ѻ�ȡ����ԱȨ��)
set /p url=����������ָ����������:
if "%url%"=="" (
set url=upos-hz-mirrorakam.akamaized.net &goto :jx
) else (
goto :jx
)
:jx
echo.|python %~dp0\akamTester.py -u "%url%"
for /f "tokens=2 skip=13 delims= " %%i in (%~dp0\%url%.txt) do set /a num=%%i+17 &goto ip2
:ip2
for /f "eol=�� tokens=1,3 skip=%num%" %%i in (%~dp0\%url%.txt) do echo %%i %%j>>%~dp0\temp.txt
find /v "" /c %~dp0\temp.txt >%~dp0\log.txt
for /f "tokens=3 skip=1 delims= " %%i in (%~dp0\log.txt) do set lines=%%i
for /f "tokens=2" %%i in (%~dp0\temp.txt) do echo %%i>>%~dp0\results2.txt
sort %~dp0\results2.txt >%~dp0\sort.txt
set /p a=<%~dp0\sort.txt
find /i "%a%" "%~dp0\temp.txt" >%~dp0\temp2.txt
for /f "tokens=1" %%i in (%~dp0\temp2.txt) do set ip=%%i
findstr /v "#URL����%url%" "C:\Windows\System32\drivers\etc\hosts">C:\Windows\System32\drivers\etc\hosts2
xcopy /y /c /h /r "C:\Windows\System32\drivers\etc\hosts2" "C:\Windows\System32\drivers\etc\hosts" > nul
echo %ip% %url% #URL����%url%>>C:\Windows\System32\drivers\etc\hosts
set /a num2=%num%-1
for /f "eol=�� skip=%num2% delims=" %%i in (%~dp0\%url%.txt) do echo %%i>>%~dp0\results3.txt
type %~dp0\%url%.txt
del %~dp0\temp.txt %~dp0\temp2.txt %~dp0\sort.txt %~dp0\results2.txt %~dp0\log.txt %~dp0\results3.txt
pause
goto :start