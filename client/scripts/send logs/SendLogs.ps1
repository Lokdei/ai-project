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

Function GetOSFilePath {
  Param(
    [string]$OSVersion
  )
  [string[]] $result = '0', '1'
  if ($OSVersion.Equals('windows')) {
    $result[0] = "C:\ProgramData\osquery\log\osqueryd.results.log"
    $result[1] = "C:\SendLog\SendLog.log"
  }
  elseif ($OSVersion.Equals('macOs')) {
    $result[0] = "/var/log/osquery/osqueryd.results.log"
    $result[1] = '~/Desktop/SendLog.log'
  }
  elseif ($OSVersion.Equals('ubuntu')) {
    $result[0] = "/var/log/osquery/osqueryd.results.log"
    $result[1] = "/var/log/SendLog/testlog.log"
  }
  return $result
}

Function WriteLog {
  Param(
    [string]$loggable,
    [string]$scriptLogPath
  )
  
  $addToLog = '{"timestamp": "' + $(Get-Date -Format s) + '", "result":"' + $loggable + '"}'  

  Add-Content $scriptLogPath $addToLog
}

Function SendToElasticSearch {
  Param(
    [ValidateSet('windows', 'macOs', 'ubuntu')]
    [string] 
    $OSVersion 
  )

  $arr = GetOSFilePath -OSVersion $OSVersion
  $osqueryLogPath = $arr[0]
  $scriptLogPath = $arr[1]

  WriteLog -scriptLogPath $scriptLogPath -loggable 'run_start'

  # Check for logs
  if (-Not (Test-Path $osqueryLogPath)) {
    Write-Host 'no_file'
    WriteLog -scriptLogPath $scriptLogPath -loggable 'no_file'
    WriteLog -scriptLogPath $scriptLogPath -loggable 'run_end' 
    return
  }

  # Read logdata
  $logContent = Get-Content -Path $osqueryLogPath # | Select-Object -last 5
   
  # Remove file after read
  Remove-Item -Path $osqueryLogPath

  # Create web request
  $uri = "http://192.168.10.44:9200/osquery/query-" + $(Get-Date -Format yyyy.MM.dd)
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
    WriteLog -scriptLogPath $scriptLogPath -loggable $response.Content 
  }

  WriteLog -scriptLogPath $scriptLogPath -loggable $i
  WriteLog -scriptLogPath $scriptLogPath -loggable 'run_end' 
}

# We uncommented it because we can't seem to start the script with parameters as a process start
# Currently we're doing powershell "C:\SendLog\SendLogs.ps1"
# Since we can't pass parameters in Program.cs we hardcoded it

# Add this as parameter to automatically execute for the correct OS version
SendToElasticSearch -OSVersion windows
