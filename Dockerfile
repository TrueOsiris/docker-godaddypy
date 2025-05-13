FROM ubuntu:20.04
MAINTAINER tim@chaubet.be
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update && \
    apt install -y python3 git python3-pip tzdata cron logrotate && \
    rm -rf /var/lib/apt/lists/* && \
    apt clean
RUN pip install godaddypi configloader
ENV TZ=Europe/Brussels
COPY start.sh /start.sh
RUN chmod +x /start.sh
COPY godaddy_updater.py /godaddy_updater.py
RUN chmod +x /godaddy_updater.py
VOLUME ["/logdir"]
CMD ["/start.sh"]

