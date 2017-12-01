# ai-project
Bert, Cedric, Michiel

# Requirements
**Client:** 
- [Osquery](https://osquery.io/downloads/)
- Powershell

**Server:**
- [Java JRE](https://java.com/en/download/win10.jsp)
- [Kibana](https://www.elastic.co/downloads/kibana)
- All kibana plugins
- [ElasticSearch](https://www.elastic.co/products/elasticsearch)

# Install
Follow the [WindowsInstaller.bat](WindowsInstaller.bat)

## Troubleshoot Osquery
### General guide
Troubleshoot with this guide: https://medium.com/@clong/osquery-for-security-b66fffdf2daf

### Problem: Config file
(Requires unix machine)
Troubleshoot the config file: 
`sudo osqueryctl config-check ~/Programmeren/GitHub/ai-project/osquery/honeypot.osquery.conf `

### Problem: Access Denied
Access denied to C:\ProgramData\osquery\osqueryd\
--> Give SYSTEM full permissions to the osqueryd folder

### Osqueryd has unsafe permissions
(We added the following flag by default to prevent this)
Add the --allow_unsafe flag to the osquery.flags 

## Visualise with Kibana
Go to http://192.168.0.124:5601/