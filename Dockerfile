# Dockerfile for ELK stack
# Elasticsearch 2.0.0, Logstash 2.0.0, Kibana 4.2.0, Beats support

# Based heavily on sebp/elk which is awesome!

# Build with:
# docker build -t <repo-user>/elk .

# Run with:
# docker run -p 5601:5601 -p 9200:9200 -p 5000:5000 -p 5044:5044 -it --name elk <repo-user>/elk

FROM sebp/elk:latest
MAINTAINER Juha Heimonen / flowa.fi
ENV REFRESHED_AT 2015-11-22

###############################################################################
#                                INSTALLATION
###############################################################################
COPY ./logstash-input-beats-2.0.0.gem /tmp/logstash-input-beats.gem
COPY ./logstash-codec-multiline-2.0.4.gem /tmp/logstash-codec-multiline-2.0.4.gem
RUN ["/bin/sh", "-c", "cd /opt/logstash;./bin/plugin install --no-verify /tmp/logstash-codec-multiline-2.0.4.gem"]
RUN ["/bin/sh", "-c", "cd /opt/logstash;./bin/plugin install --no-verify /tmp/logstash-input-beats.gem"]
RUN rm /tmp/logstash-input-beats.gem
RUN rm /tmp/logstash-codec-multiline-2.0.4.gem

###############################################################################
#                               CONFIGURATION
###############################################################################
# filters

ADD ./logstash-conf.d/31-beats-input.conf /etc/logstash/conf.d/31-beats-input.conf
ADD ./logstash-conf.d/32-beats-output.conf /etc/logstash/conf.d/32-beats-output.conf



###############################################################################
#                                   START
###############################################################################

EXPOSE 5601 9200 9300 5000 5044
VOLUME /etc/logstash/conf.d

CMD [ "/usr/local/bin/start.sh" ]
