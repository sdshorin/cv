# Container image that runs your code
FROM ubuntu:22.04

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh


RUN apt-get update && \
    apt-get install -yq tzdata && \
    ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata

RUN apt-get update
# RUN cd /tmp
# RUN wget https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz 
# RUN zcat < install-tl-unx.tar.gz | tar xf -
# RUN cd install-tl-*
# RUN perl ./install-tl --no-interaction
# # RUN apt-get install -y  texlive-latex-recommended 
# RUN tlmgr init-usertree
RUN tlmgr install fontawesome5

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["sh",  "/entrypoint.sh"]

