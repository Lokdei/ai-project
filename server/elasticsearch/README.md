# Installation
1. Download the msi installer from [download page](https://www.elastic.co/downloads/elasticsearch) or download the previous version if the latest version doesn't work. We had to use the [elasticsearch 5.6.5 version](https://www.elastic.co/downloads/past-releases/elasticsearch-5-6-5).
2. You can leave all the settings as default.
	We had to run the configuration with 1.8GB memory because we hadn't enough memory.
3. For plugins you can select X-pack. X-pack has a lot of features that can help the monitoring of a system.
	You can find more information on the [X-pack page](https://www.elastic.co/products/x-pack).
	X-pack is recommended to use because there's machine learning in the package what could help a lot with the project.
4. After the selections of the plugins you can install elasticsearch.
5. When the installation is completed you can exit the installation wizard.

# Configuration

Now we need to add an index for Osquery, the folowing instructions use our ip.
GET http://192.168.10.44:9200/_cat/indices

You can use [Postman](https://www.getpostman.com/) to faciliate the process.

## Create the osquery index
Create a new request 

Add a header: 
- Key: `Authorization`  
- Value: `Basic ZWxhc3RpYzpjaGFuZ2VtZQ==`  

The value is your password in base64

Add the content body (JSON)
```json
{
    "settings" : {
        "index" : {
            "number_of_shards" : 1
        }
    }
}
```

Send a PUT request at: http://192.168.10.44:9200/osquery

Refresh your indices (reload http://192.168.10.44:9200/_cat/indices), your osquery index should be added.

## Send data
You can try to send data with the SendLogs.ps1 script. The index size should increase.

# Remarks

We only used 1 index, but it's advantageous to use an index with the following format osquery-YYYY-MM-DD. Logstash does this by default.
