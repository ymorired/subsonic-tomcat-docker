FROM ubuntu:latest

MAINTAINER ymorired

RUN apt-get update && \
    apt-get install -yq software-properties-common && \
    DEBIAN_FRONTEND=noninteractive add-apt-repository ppa:mc3man/trusty-media && \
    apt-get update && \
    apt-get install -yq ffmpeg lame openjdk-7-jre && \
    apt-get install -yq --no-install-recommends wget pwgen ca-certificates && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# INSTALL TOMCAT
ENV TOMCAT_MAJOR_VERSION 7
ENV TOMCAT_MINOR_VERSION 7.0.65
ENV CATALINA_HOME /tomcat

RUN wget -q https://archive.apache.org/dist/tomcat/tomcat-${TOMCAT_MAJOR_VERSION}/v${TOMCAT_MINOR_VERSION}/bin/apache-tomcat-${TOMCAT_MINOR_VERSION}.tar.gz && \
    wget -qO- https://archive.apache.org/dist/tomcat/tomcat-${TOMCAT_MAJOR_VERSION}/v${TOMCAT_MINOR_VERSION}/bin/apache-tomcat-${TOMCAT_MINOR_VERSION}.tar.gz.md5 | md5sum -c - && \
    tar zxf apache-tomcat-*.tar.gz && \
    rm apache-tomcat-*.tar.gz && \
    mv apache-tomcat* tomcat

RUN rm -rf /tomcat/webapps/* && \
    wget -q -O /tomcat/webapps/ROOT.war https://github.com/EugeneKay/subsonic/releases/download/v5.3-kang/subsonic-v5.3-kang.war && \
    mkdir -p /var/music /var/playlists /var/subsonic

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

EXPOSE 8080
VOLUME ["/var/playlists","/var/music", "/var/subsonic"]

WORKDIR ${CATALINA_HOME}/bin
CMD [ "./catalina.sh", "run" ]

