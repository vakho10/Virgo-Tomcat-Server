FROM openjdk:8-jre
MAINTAINER Vakho 
ENV VIRGO_VERSION 3.7.2.RELEASE
ENV VIRGO virgo-tomcat-server-$VIRGO_VERSION 
ENV VIRGO_HOME /opt/virgo 

RUN apk add --update curl libarchive-tools bash

RUN \
	curl -o virgo.zip -L http://www.eclipse.org/downloads/download.php?file=/virgo/release/VP/$VIRGO_VERSION/$VIRGO.zip\&r=1 && \
	mkdir -p /opt && \
	bsdtar -C /opt/ -xzf virgo.zip && \
	rm virgo.zip && \
	ln -s /opt/$VIRGO $VIRGO_HOME && \
	adduser -D -s /bin/bash -h $VIRGO_HOME virgo && \
	chmod u+x /opt/$VIRGO/bin/*.sh && \
	chown virgo:virgo /opt/$VIRGO -R

USER virgo 
WORKDIR $VIRGO_HOME

RUN sed -i 's/127.0.0.1/0.0.0.0/g' /home/virgo/configuration/tomcat-server.xml

EXPOSE 8080 

CMD ["bin/startup.sh"]