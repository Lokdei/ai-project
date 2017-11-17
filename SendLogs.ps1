#powershell ise als admin openen. 1 maal Set-ExecutionPolicy Unrestricted uitvoeren. dan ist goe

$user = "elastic"
$pass = "changeme"
$pair = "${user}:${pass}"

$bytes = [System.Text.Encoding]::ASCII.GetBytes($pair)
$base64 = [System.Convert]::ToBase64String($bytes)

$basicAuthValue = "Basic $base64"



$call = {
    param($verb, $body)

    $uri = "http://192.168.10.44:9200/osquery/query"

    $headers = @{ 
        'Authorization' = $basicAuthValue
    }

    Write-Host "`nCalling [$uri]" -f Green
    if($body) {
        if($body) {
            Write-Host "BODY`n--------------------------------------------`n$body`n--------------------------------------------`n" -f Green
        }
    }

    $response = Invoke-WebRequest -UseBasicParsing $uri -Method Post -Headers $headers -ContentType 'application/json' -Body $body


    #$response = wget -Uri "$uri/$uriParams" -method $verb -Headers $headers -ContentType 'application/json' -Body $body
    $response.Content
}


Function post  {
    Param($body)
    &$call "Post" $body
}

$testBody = '{"hello":"world"}'
