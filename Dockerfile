FROM ubuntu:20.04
MAINTAINER tim@chaubet.be
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update
RUN apt install -y python3 git python3-pip tzdata cron && \
    rm -rf /var/lib/apt/lists/* && \
    apt clean
RUN pip install pif
ENV TZ=Europe/Brussels
COPY start.sh /start.sh
RUN chmod +x /start.sh
COPY godaddy_updater.py /godaddy_updater.py
RUN chmod +x /godaddy_updater.py
CMD ["./start.sh"]

