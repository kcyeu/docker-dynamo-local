FROM ubuntu:latest
MAINTAINER Kuo-Cheng Yeu <kmd@mikuru.tw>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -qq update && apt-get -qqy install \ 
    openjdk-7-jre-headless \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

# Fetch dynamodb local and install it
ADD http://dynamodb-local.s3-website-us-west-2.amazonaws.com/dynamodb_local_latest.tar.gz dynamodb.tar.gz

RUN mkdir -p dynamodb_local \ 
&& tar xvzf dynamodb.tar.gz -C ./dynamodb_local \ 
&& rm -rf dynamodb.tar.gz \
    dynamodb_local/DynamoDBLocal_lib/*win32* \
    dynamodb_local/DynamoDBLocal_lib/*osx*

EXPOSE 8000

CMD ["java", "-Djava.library.path=./dynamodb_local/DynamoDBLocal_lib", "-jar", "./dynamodb_local/DynamoDBLocal.jar"]

