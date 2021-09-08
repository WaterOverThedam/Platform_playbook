curl -X PUT http://localhost:19200/_cluster/settings -H 'Content-Type: application/json' -d'{
    "persistent" : {
        "search.max_open_scroll_context": 5000
    },
    "transient": {
        "search.max_open_scroll_context": 5000
    }
}'
#curl -X PUT 'http://127.0.0.1:19200/cli_search_medicine/_settings' -H 'Content-Type: application/json' -d'{ "index.mapping.total_fields.limit": 5000 }'
#curl -X PUT 'http://127.0.0.1:19200/cli_search_cs_all/_settings' -H 'Content-Type: application/json' -d'{ "index.mapping.total_fields.limit": 5000 }'