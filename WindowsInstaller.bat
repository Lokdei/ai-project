REM Open Administrative Shell
REM Install Chocolatey
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

REM Download Osquery
choco install osquery
Y

REM Install Osqueryd
C:\ProgramData\osquery\osqueryd\osqueryd.exe --install

REM Configure Osqueryd
REM C:\ProgramData\osquery\osquery.conf
REM https://raw.githubusercontent.com/BertGoens/ai-project/master/osquery/windows.osquery.conf

REM Test Osqueryd
C:\ProgramData\osquery\osqueryd\osqueryd.exe --verbose
REM Should tell you osqueryd is already running


REM Create SendLogs.sp1 in C:\SendLog\SendLogs.ps1
REM (Optional: test the script once)

REM Create a task to run the script every 5 minutes
REM General:    Run whether the user is logged in or not
REM Trigger:    Daily, Every 5 minutes
REM Action:
REM   Location:   C:\Windows\SysWOW64\WindowsPowerShell\v1.0\powershell.exe
REM   Arguments:  -ExecutionPolicy Bypass C:\SendLog\SendLogs.ps1