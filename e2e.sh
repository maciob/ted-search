#!/bin/bash
declare -a ENDPOINTS=("auditevents" "beans" "caches" "health" "conditions" "configprops" "env" "info" "loggers" "heapdump" "threaddump" "prometheus" "metrics" "scheduledtasks" "httptrace" "mappings")
for x in ${ENDPOINTS[@]}
do
    response=$(curl -i http://$1:$2/actuator/$x 2>/dev/null | head -n 1 | cut -d$' ' -f2)
    echo "$response"
    if [ $response -eq 200 ]
    then
        echo "test $x passed"
    else
        echo "test $x failed"
    fi
done
