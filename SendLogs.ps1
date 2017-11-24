# For developers only
# Open powershell as admin & execute the following once
# Set-ExecutionPolicy Unrestricted

# For clients
# Add the script to the Windows Task Scheduler at an interval (5min)
# Powershell.exe -ExecutionPolicy Bypass C:\SendLog\SendLogs.ps1

$user = "elastic"
$pass = "changeme"
$pair = "${user}:${pass}"

$bytes = [System.Text.Encoding]::ASCII.GetBytes($pair)
$base64 = [System.Convert]::ToBase64String($bytes)

$basicAuthValue = "Basic $base64"

$macOsqueryLogPath = "/var/log/osquery/osqueryd.results.log"
$macScriptLogPath = '~/Desktop/SendLog.log'

$windowsOsqueryLogPath = "C:\ProgramData\osquery\log\osqueryd.results.log"
$windowsScriptLogPath = "C:\SendLog\SendLog.log"

$ubuntuOsqueryLogPath = "/var/log/osquery/osqueryd.results.log"
$ubuntuScriptLogPath = "/var/log/SendLog/testlog.log"

Function MakeLogObject {
  Param(
    [string]$loggable
  )
  return '{"timestamp": "' + $(Get-Date -Format s) + '", "result":"' + $loggable + '"}'
}

Function SendToElasticSearch {
  Param(
    [string]$osqueryLogPath,
    [string]$scriptLogPath
  )

  Add-Content $scriptLogPath $(MakeLogObject -loggable 'run_start') 

  # Check for logs
  if (-Not (Test-Path $osqueryLogPath)) {
    Add-Content $scriptLogPath $(MakeLogObject -loggable 'no_file')
    return
  }

  # Read logdata
  $logContent = Get-Content -Path $osqueryLogPath # | Select-Object -last 5
   
  # Remove file after read
  Remove-Item -Path $osqueryLogPath

  # Create web request
  $uri = "http://192.168.10.44:9200/osquery/query"
  $headers = @{ 
    'Authorization' = $basicAuthValue
  }

  $i = 0
  ForEach ($line in $($logContent -split '\r?\n')) {
    # Create the body
    $jsonObject = $(ConvertFrom-Json -InputObject $line);
    # Add the current time 
    $jsonObject | add-member -Name "sent_at" -value $(Get-Date -Format s) -MemberType NoteProperty

    # Send web request and store the response
    $response = Invoke-WebRequest `
      -UseBasicParsing $uri `
      -Method Post `
      -Headers $headers `
      -ContentType 'application/json' `
      -Body (ConvertTo-Json $jsonObject)

    # Counter
    # Write-Host $i
    $i = $i + 1
    Write-Host $i

    # Log the response
    Add-Content $scriptLogPath $(MakeLogObject -loggable $response.Content) 
  }

  Add-Content $scriptLogPath $(MakeLogObject -loggable $i ) 
  Add-Content $scriptLogPath $(MakeLogObject -loggable 'run_end') 
}

#SendToElasticSearch -scriptLogPath $macScriptLogPath -osqueryLogPath $macOsqueryLogPath
SendToElasticSearch -scriptLogPath $windowsScriptLogPath -osqueryLogPath $windowsOsqueryLogPath