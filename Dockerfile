FROM openjdk:8-jre-alpine
MAINTAINER Gabor Renner <grenner@intrend.hu>

ENV VIRGO_VERSION 3.7.2.RELEASE
ENV VIRGO virgo-tomcat-server-$VIRGO_VERSION
ENV VIRGO_HOME /opt/virgo

RUN apk add --update curl libarchive-tools bash && mkdir -p /opt/$VIRGO
COPY virgo-tomcat-server-3.7.2.RELEASE /opt/$VIRGO

RUN  ls /opt/ && ln -s /opt/$VIRGO $VIRGO_HOME && \
	adduser -D -s /bin/bash -h $VIRGO_HOME virgo && \ 
	chmod u+x /opt/$VIRGO/bin/*.sh && \
	chown virgo:virgo /opt/$VIRGO -R

USER virgo

WORKDIR $VIRGO_HOME

RUN sed -i 's/127.0.0.1/0.0.0.0/g' /opt/virgo/configuration/tomcat-server.xml
EXPOSE 8080

CMD ["bin/startup.sh"]