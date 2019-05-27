#!/bin/bash
BEAT=metricbeat
TIME_TO_WAIT=5
KIBANA_URL=http://localhost:5601/app/kibana

while true
do
  STATUS=$(curl --write-out %{http_code} --silent --output /dev/null $KIBANA_URL)
  if [ $STATUS -eq 200 ]; then
    echo "Got 200! Kibana is operational."
    break
  else
    echo "Got $STATUS :( Kibana is not ready yet..."
  fi
	echo "Waiting for $TIME_TO_WAIT seconds before retrying Kibana ..."
  sleep $TIME_TO_WAIT
done

echo "Setting up Kibana dashboards for $BEAT ..."
# Load the sample dashboards for the Beat.
# REF: https://www.elastic.co/guide/en/beats/metricbeat/master/metricbeat-sample-dashboards.html
docker exec -it ${BEAT} /bin/sh -c "${BEAT} --strict.perms=false setup -v"
