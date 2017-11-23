#powershell ise als admin openen. 1 maal Set-ExecutionPolicy Unrestricted uitvoeren. dan ist goe

$user = "elastic"
$pass = "changeme"
$pair = "${user}:${pass}"

$bytes = [System.Text.Encoding]::ASCII.GetBytes($pair)
$base64 = [System.Convert]::ToBase64String($bytes)

$basicAuthValue = "Basic $base64"

$macOsqueryLogPath = "/var/log/osquery/osqueryd.results.log"
$macScriptLogPath = '~/Desktop/script-results.log'

$windowsOsqueryLogPath = "C:\ProgramData\osquery\log\osqueryd.results.log"
$windowsScriptLogPath = "C:\Users\$([Environment]::UserName)\Desktop\testlog.log"

Function SendToElasticSearch {
  Param(
    [string]$osqueryLogPath,
    [string]$scriptLogPath
  )

  # Read data
  $logContent = Get-Content -Path $osqueryLogPath | Select-Object -last 30;
  $jsonConcat = '[' + $logContent + ']'

  # Create web request
  $uri = "http://192.168.10.44:9200/osquery/query"
  $headers = @{ 
    'Authorization' = $basicAuthValue
  }

  $i = 1
  ForEach ($line in $($logContent -split "`r`n")) {
    # Send web request and store the response
    $response = Invoke-WebRequest `
      -UseBasicParsing $uri `
      -Method Post `
      -Headers $headers `
      -ContentType 'application/json' `
      -Body $line 

    # Counter
    Write-Host $i
    $i = $i + 1
    
    # Log the response
    Add-Content $scriptLogPath $response.Content
  }
}

SendToElasticSearch -scriptLogPath $macScriptLogPath -osqueryLogPath $macOsqueryLogPath
