$json = @"
{
  "name": "test",
  "hostIdentifier": "Berts-MacBook-Pro.local",
  "calendarTime": "Fri Nov 24 12:03:01 2017 UTC",
  "unixTime": "1511524981",
  "epoch": "0",
  "counter": "0",
  "decorations": {
    "address": "172.31.28.166",
    "host_uuid": "02763831-3CB6-596C-8039-7D9589EEC8E2",
    "iso_8601": "2017-11-24T12:02:57Z",
    "username": "BertGoens"
  },
  "columns": {
    "config_hash": "d5bc32d7d7cbc8985e1b48aced685a4dcdea9078",
    "config_valid": "1"
  },
  "action": "added"
}
"@

$jobj = ConvertFrom-Json -InputObject $json

$jobj | add-member -Name "sent_at" -value $(Get-Date -Format s) -MemberType NoteProperty
write-host (ConvertTo-Json $jobj)