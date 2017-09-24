curl -XDELETE http://localhost:9200/nxapi
curl -XPUT http://localhost:9200/nxapi
curl -XPUT http://localhost:9200/nxapi/_mapping/events -d@mapping.json
