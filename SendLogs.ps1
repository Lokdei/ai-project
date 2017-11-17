# Initial Version to try and send data from Windows clients 
# to the ElasticSearch server

function getAddress () {
  "http://192.168.10.44:9200/"
}

Invoke-WebRequest -UseBasicParsing getAddress(null) -
Method POST -ContentType "application/json" -Body '{
"user" : "elastic",
"password" : "changeme",
"post_date" : "'Get-Date -Format s '",
"message" : "trying out Elasticsearch"
}'

