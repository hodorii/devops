FROM openjdk:alpine
MAINTAINER hodorii hodorii@gmail.com

RUN apk add --no-cache curl unzip bash
ENV ARTIFACTORY_VERSION 4.15.0
ENV ARTIFACTORY_NAME artifactory-oss-$ARTIFACTORY_VERSION
ENV ARTIFACTORY_FILE jfrog-$ARTIFACTORY_NAME.zip
ENV ARTIFACTORY_URL https://bintray.com/artifact/download/jfrog/artifactory/$ARTIFACTORY_FILE

RUN cd "/tmp" \
 && curl -LO $ARTIFACTORY_URL \
 && unzip $ARTIFACTORY_FILE \
 && mv $ARTIFACTORY_NAME "/usr/local/artifactory/"
# && cleanimage

WORKDIR /usr/local/artifactory

VOLUME "/usr/local/artifactory/data" 
VOLUME "/usr/local/artifactory/etc"
VOLUME "/usr/local/artifactory/logs"
VOLUME "/usr/local/artifactory/backup"

CMD bin/artifactory.sh

EXPOSE 8081
