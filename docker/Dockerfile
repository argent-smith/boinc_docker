FROM ubuntu:wily

MAINTAINER argent_smith (argentoff@gmail.com)

# preparations
ENV DEBIAN_FRONTEND noninteractive
ENV TERM linux
RUN sed -i 's/^mesg n$/tty -s \&\& mesg n/g' /root/.profile
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections


RUN apt-get update \
    && apt-get install -y locales \
                          lib32z1 lib32ncurses5 \
                          libstdc++6 \
                          freeglut3 \
                          boinc-client \
                          boinctui \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

# Locale
RUN rm -rf /var/lib/apt/lists/* && \
    localedef -i ru_RU -c -f UTF-8 -A /usr/share/locale/locale.alias ru_RU.UTF-8
ENV LANG ru_RU.UTF-8
ENV LANGUAGE ru_RU:UTF-8
ENV LC_ALL ru_RU.UTF-8

# TZ
RUN echo Europe/Moscow > /etc/timezone && \
    dpkg-reconfigure -f noninteractive tzdata

RUN rm -f /etc/boinc-client/gui_rpc_auth.cfg

COPY ./config/gui_rpc_auth.cfg /etc/boinc-client/gui_rpc_auth.cfg

RUN mkdir -p /var/lib/boinc-client && \
    chown -R boinc:boinc /var/lib/boinc-client

RUN mkdir /backups && \
    chown -R boinc:boinc /backups

# go out of setup mode
RUN echo 'debconf debconf/frontend select Dialog' | debconf-set-selections

VOLUME /var/lib/boinc-client

WORKDIR /var/lib/boinc-client

USER boinc

CMD boinc --allow_remote_gui_rpc
