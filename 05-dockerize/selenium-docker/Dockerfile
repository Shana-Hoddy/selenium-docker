#build the jar files using this, configured in pom pluggins > docker build -t vinsdocker/selenium .  #[accountname/nameOfproj] '.' current directory
#bring up the hub & chrome & firefox container: docker-compose up
# docker-compose.yaml has a dependency on the vinsdocker/selenium docker container and looks for a local dockerfile.
#it executes the dockerfile to bring the container up.

 # we don't need to do this, it will be brought up by the docker-compose up command.
#run it> docker run vinsdocker/selenium --entrypoint=/bin/sh vinsdocker/selenium
#cd test-data/vendor-portal
#

FROM bellsoft/liberica-openjdk-alpine:17.0.8

# Install curl jq, need to install because we use curl and jq in our runner.sh file to check if the hub is up.
RUN apk add curl jq

# workspace
WORKDIR /home/selenium-docker

# Add the required files, the target/docker-resources are configured via the pom file and then created using mvn package -Dskiptests
ADD target/docker-resources     ./
ADD runner.sh                   runner.sh


#moved this command to the runner.sh file
#ENVIRONMENT VARIABLES
#BROWSER, HUB_HOST, TEST_SUITE, THREAD_COUNT
#ENTRYPOINT java -cp 'libs/*' \
# -Dselenium.grid.enabled=true \
# -Dselenium.grid.hubhost=${HUB_HOST} \
# -Dbrowser=${BROWSER}
# org.testNG.TESTNG -threadcount ${THREAD_COUNT} \ #Threadcount is a testNG parameter
# test-suites/${TEST_SUITE}

# Start the runner.sh
ENTRYPOINT sh runner.sh

#but docker-compose this so we don't have to do on command line
#docker run -e BROWSER=FIREFOX -e HUB_HOST=192.168.1.118 TEST_SUITE=flight-reservation.xml -e=THREAD_COUNT=4 vinsdocker/selenium