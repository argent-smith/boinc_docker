FROM ubuntu:16.04

MAINTAINER argent_smith (argentoff@gmail.com)

RUN apt-get update \
    && apt-get install -y locales \
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

RUN mkdir -p /var/lib/boinc-client && \
    chown -R boinc:boinc /var/lib/boinc-client

VOLUME /var/lib/boinc-client

WORKDIR /var/lib/boinc-client

RUN rm -f /etc/boinc-client/gui_rpc_auth.cfg

COPY ./config/gui_rpc_auth.cfg /etc/boinc-client/gui_rpc_auth.cfg

USER boinc

CMD boinc --allow_remote_gui_rpc
