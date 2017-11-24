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

## Start Osquery
Problems: troubleshoot with this guide: https://medium.com/@clong/osquery-for-security-b66fffdf2daf

Example Start command
```bash
# Windows
C:\ProgramData\osquery\osqueryd\osqueryd.exe --config_path=C:/ProgramData/osquery/osquery.conf  --verbose
# Linux

# MacOs
```

## Visualise with Kibana
Go to http://192.168.0.124:5601/