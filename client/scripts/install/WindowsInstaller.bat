ECHO OFF

REM Check if the script is running with admin privileges
REM If it's not, display a warning and exit
NET SESSION >nul 2>&1
IF %ERRORLEVEL% EQU 0 (
    ECHO "Administrator PRIVILEGES Detected!"
) ELSE (
    ECHO "NOT AN ADMIN!"
    PAUSE
    EXIT /B 1
)

REM Install Chocolatey
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

ECHO "Download Osquery"
REM Add the "-y" flag to automatically confirm all prompts
choco install osquery -y

ECHO "Install Osqueryd"
C:\ProgramData\osquery\osqueryd\osqueryd.exe --install

ECHO Configure Osqueryd
REM C:\ProgramData\osquery\osquery.conf
DEL "C:\ProgramData\osquery\osquery.example.conf" 
REM https://raw.githubusercontent.com/BertGoens/ai-project/master/osquery/honeypot.osquery.conf
powershell -Command "Invoke-WebRequest https://raw.githubusercontent.com/BertGoens/ai-project/master/osquery/honeypot.osquery.conf -OutFile C:\ProgramData\osquery\osquery.conf"
powershell -Command "Invoke-WebRequest https://raw.githubusercontent.com/BertGoens/ai-project/master/osquery/osquery.flags -OutFile C:\ProgramData\osquery\osquery.flags"

REM Create SendLogs.sp1 in C:\SendLog\SendLogs.ps1
mkdir C:\SendLog
powershell -Command "Invoke-WebRequest https://raw.githubusercontent.com/BertGoens/ai-project/master/SendLogs.ps1 -OutFile C:\SendLog\SendLogs.ps1"

ECHO "Create a task to run the script every n minutes"
SchTasks /Create /SC ONSTART /MO 3 /TN “Send osquery logs to elasticsearch” /TR “:\Windows\SysWOW64\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy Bypass C:\SendLog\SendLogs.ps1” /ST 09:00
REM /TN = Task Name
REM /SC = Schedule (minutes)
REM /TR = Task Run
REM /ST = Start Time

REM Trigger:    Daily, Every 5 minutes, Indefinitely
REM Action:
REM   Location:   C:\Windows\SysWOW64\WindowsPowerShell\v1.0\powershell.exe
REM   Arguments:  -ExecutionPolicy Bypass C:\SendLog\SendLogs.ps1

PAUSE