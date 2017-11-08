# ai-project
Bert, Cedric, Michiel

# Requirements
**Client:** 
- [Osquery](https://osquery.io/downloads/)
- [Java JRE](https://java.com/en/download/win10.jsp)
- [Logstash](https://www.elastic.co/downloads/logstash)

**Server:**
- [Kibana](https://www.elastic.co/downloads/kibana)
- All kibana plugins

## Start Osquery
Problems: troubleshoot with this guide: https://medium.com/@clong/osquery-for-security-b66fffdf2daf

osqueryd --verbose

## Start Logstash
Make sure you have Java installed and working.  
Copy the logstash config file and execute with it.

## Visualise with Kibana
Go to http://192.168.0.124:5601/