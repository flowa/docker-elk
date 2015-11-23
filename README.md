# docker-elk, with Beats

This is a repository that contains ELK stack with beats integration. The basic configuration enables you to send some
test beats, but you most likely want to bake your own image, or mount the volume /etc/logstash/conf.d to other container
or host.

Builds upon http://elk-docker.readthedocs.org/

Which is awesome. Read the documentation from there, you'll get the basics. The only addition is 
the logstash-input-beats plugin, which is installed from local gem.

Soon there should be an official version available that's compatible with current filebeat messages.

## Exposed ports

* 5601 - Kibana
* 9200 - Elastic search JSON interface
* 9300 - Elastic search transport
* 5000 - Logstash
* 5044 - Logstash beats input port

## Customisation

Exposes

  /etc/logstash/conf.d

So you can configure logstash however you wish. For easy testing with current setup,
you can most likely link this container with something like

  fiunchinho/docker-filebeat

for quick testing.

## Warning

Don't use in production. You want to bake your own image with proper ssl certificates set.

## TODO

Add examples of how to use this container.
