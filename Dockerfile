FROM ubuntu:16.04

MAINTAINER argent_smith (argentoff@gmail.com)

RUN apt-get update && \
    apt-get install -y boinc-client


RUN mkdir -p /var/lib/boinc-client && \
    chown -R boinc:boinc /var/lib/boinc-client

VOLUME /var/lib/boinc-client

WORKDIR /var/lib/boinc-client

RUN rm -f /etc/boinc-client/gui_rpc_auth.cfg

COPY ./config/gui_rpc_auth.cfg /etc/boinc-client/gui_rpc_auth.cfg

USER boinc

CMD boinc --allow_remote_gui_rpc
