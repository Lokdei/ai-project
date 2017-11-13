# ai-project
Bert, Cedric, Michiel

# Requirements
**Client:** 
- [Osquery](https://osquery.io/downloads/)
- [Java JRE](https://java.com/en/download/win10.jsp)
- [Logstash](https://www.elastic.co/downloads/logstash)

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

## Start Logstash
Make sure you have Java installed and working.  
Copy the logstash config file and execute with it.

```bash
# Windows
# Make sure your logstash path has no space in it, it bugs out.
C:\logstash\logstash-5.6.4\bin\logstash.bat -f C:\logstash\osquery-elasticsearch.conf
# Linux
# Added script to /bin
logstash-start  
# MacOs
# Using homebrew
logstash -f ~/.logstash/osquery-elasticsearch.config
```

## Visualise with Kibana
Go to http://192.168.0.124:5601/