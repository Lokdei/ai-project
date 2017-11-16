REM Open Administrative Shell
REM Install Chocolatey
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

REM Download Osquery
choco install osquery
Y

REM Install Osqueryd
C:\ProgramData\osquery\osqueryd\osqueryd.exe --install

REM Install Java
REM https://www.java.com/nl/download/windows-64bit.jsp
REM Add Java to the PATH variables
set PATH=%PATH%;C:\Program Files\Java\jre1.8.0_151
REM Also add JAVA_HOME to user environment 

REM Install Logstash
REM https://www.elastic.co/downloads/logstash

REM Configure Osqueryd
REM C:\ProgramData\osquery\osquery.conf
REM https://raw.githubusercontent.com/BertGoens/ai-project/master/osquery/windows.osquery.conf

REM Configure Logstash
REM C:\Logstash\logstash.conf
REM https://github.com/BertGoens/ai-project/blob/master/logstash/windows.osquery-elasticsearch.conf

REM REBOOT

REM Test Osqueryd
C:\ProgramData\osquery\osqueryd\osqueryd.exe --verbose
REM Should tell you osqueryd is already running

REM Test logstash
C:\Logstash\run_logstash.bat