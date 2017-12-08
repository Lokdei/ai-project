# Installation
1. Go the the [download page](https://www.elastic.co/downloads/kibana), they have easy to follow instructions and download Kibana.
2. Change the [kibana.yml](./kibana.yml) rules to match
3. Start kibana (kibana.bat)

# Configuration

1. Go to [http://YOUR_PUBLIC_IP:5601/](http://127.0.0.1:5601) (In our case: http://192.168.10.44:5601/)
2. Log in with the username and password defined in [kibana.yml](./kibana.yml)
3. Create a default Index pattern (*)
4. Create an index specific for our data, let's call it `osquery-*` (or osquery*). As a time filter we can use `sent_at`  
5. Import our visualisations and dashboard. 
6. If you want the same visualisations on your index change the visualisations.json index to match yours and import again.