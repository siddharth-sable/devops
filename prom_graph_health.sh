#!/bin/bash/
graph_response=$(curl -o /dev/null -s -w "%{http_code}\n" http://localhost:3000)
prom_response=$(curl -o /dev/null -s -w "%{http_code}\n" http://localhost:9090)
if [ "$graph_response" != "404" ] && [ "$prom_response" != "404" ]; then
    echo -e "\e[1;32m[+]Grafana and Prometheus is running \e[0m"
else
    echo -e "\e[1;32m[!]Status: Grafana and Prometheus inactive \e[0m"
fi
