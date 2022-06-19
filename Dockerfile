# Container image that runs your code
FROM ubuntu:20.04

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh


RUN apt-get update && \
    apt-get install -yq tzdata && \
    ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata

RUN apt-get update
RUN apt-get install -y texlive-xetex

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["sh",  "/entrypoint.sh"]

