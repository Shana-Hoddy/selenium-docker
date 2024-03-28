#!/bin/bash
#-------------------------------------------------------------------
#  This script expects the following environment variables
#     HUB_HOST
#     BROWSER
#     THREAD_COUNT
#     TEST_SUITE
#-------------------------------------------------------------------
# Let's print what we have received
echo "-------------------------------------------"
echo "HUB_HOST      : ${HUB_HOST:-hub}"
echo "BROWSER       : ${BROWSER:-chrome}"
echo "THREAD_COUNT  : ${THREAD_COUNT:-1}"
echo "TEST_SUITE    : ${TEST_SUITE}"
echo "-------------------------------------------"

# Do not start the tests immediately. Hub has to be ready with browser nodes
#>curl http://localhost:4444/status, returns json file with "ready"=true]
#using jq utility to process the json input, this gives the output to the jq utility
#>curl http://localhost:4444/status | jq ready.value (will just give us the node value of ready.value
#we need to install jq and curl on our image - so in our dockerfile we have > RUN apk add curl jq



echo "Checking if hub is ready..!"
count=0
while [ "$( curl -s http://${HUB_HOST:-hub}:4444/status | jq -r .value.ready )" != "true" ]
do
  count=$((count+1))
  echo "Attempt: ${count}"
  if [ "$count" -ge 30 ]
  then
      echo "**** HUB IS NOT READY WITHIN 30 SECONDS ****"
      exit 1
  fi
  sleep 1
done

# At this point, selenium grid should be up!
echo "Selenium Grid is up and running. Running the test...."

# Start the java command
java -cp 'libs/*' -Dselenium.grid.enabled=true -Dselenium.grid.hubHost="${HUB_HOST:-hub}" -Dbrowser="${BROWSER:-chrome}" org.testng.TestNG -threadcount "${THREAD_COUNT:-1}" test-suites/"${TEST_SUITE}"
