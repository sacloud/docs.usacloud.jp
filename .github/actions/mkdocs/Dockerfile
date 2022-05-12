FROM ubuntu:22.04
MAINTAINER Usacloud Members<sacloud.users@gmail.com>

RUN  apt-get update && apt-get -y install \
        python3 \
        python3-pip \
      && apt-get clean \
      && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*
 

ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8

WORKDIR /workdir
ADD requirements.txt /workdir
RUN pip3 install -r requirements.txt

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]