FROM openjdk:8-jre-alpine 

ENV VIRGO_VERSION 3.7.2.RELEASE 
ENV VIRGO virgo-tomcat-server-$VIRGO_VERSION 
ENV VIRGO_HOME /virgo 

RUN mkdir -p $VIRGO_HOME
RUN apk add --update curl unzip bash

RUN \
	curl -o virgo.zip -L http://www.eclipse.org/downloads/download.php?file=/virgo/release/VP/$VIRGO_VERSION/$VIRGO.zip\&r=1 && \	
	unzip -qq virgo.zip -d /tmp && \
	rm virgo.zip && \
	mv /tmp/$VIRGO/* $VIRGO_HOME && \
	addgroup -S virgo && \
    	adduser -S -s /bin/sh -G virgo -h $VIRGO_HOME virgo && \
    	chmod u+x $VIRGO_HOME/bin/*.sh

WORKDIR $VIRGO_HOME

RUN sed -i 's/127.0.0.1/0.0.0.0/g' $VIRGO_HOME/configuration/tomcat-server.xml

EXPOSE 8080 
CMD ["bin/startup.sh"]
