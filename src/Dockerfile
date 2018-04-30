FROM centos:6.8
MAINTAINER Evgenii Garunovich <garunovich@gmail.com>

WORKDIR /
ADD bitrix-env.sh /tmp
RUN chmod +x /tmp/bitrix-env.sh
RUN /tmp/bitrix-env.sh

WORKDIR /etc/init.d
RUN sed -i 's/memory=`free.*/memory=$\{BVAT_MEM\:\=262144\}/gi' bvat

ENV SSH_PASS="bitrix"
RUN echo "bitrix:$SSH_PASS" | chpasswd

# Change timezone
ENV TIMEZONE="Asia/Yekaterinburg"
RUN cp -f /usr/share/zoneinfo/$TIMEZONE /etc/localtime
RUN date

WORKDIR /tmp
ADD run.sh /tmp
RUN chmod +x /tmp/run.sh

ENTRYPOINT exec /tmp/run.sh
