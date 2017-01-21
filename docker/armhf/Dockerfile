FROM armhf/ubuntu:yakkety

MAINTAINER argent_smith (argentoff@gmail.com)

# preparations
ENV DEBIAN_FRONTEND=noninteractive \
    TERM=linux
RUN sed -i 's/^mesg n$/tty -s \&\& mesg n/g' /root/.profile
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

ENV GOSU_VERSION=1.7
RUN set -x \
    && apt-get update \
    && apt-get install -y --no-install-recommends dirmngr \
    && apt-get install -y --no-install-recommends ca-certificates wget \
    && rm -rf /var/lib/apt/lists/* \
    && wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture)" \
    && wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture).asc" \
    && export GNUPGHOME="$(mktemp -d)" \
    && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
    && gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
    && rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu \
    && gosu nobody true \
    && apt-get purge -y --auto-remove ca-certificates wget

RUN apt-get update \
    && apt-get install -y locales \
                          libstdc++6 \
                          freeglut3 \
                          boinc-client \
                          boinctui \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

# go out of setup mode
RUN echo 'debconf debconf/frontend select Dialog' | debconf-set-selections

ENV BOINC_HOME=/var/lib/boinc-client \
    BOINC_USER=boinc \
    BOINC_GROUP=boinc

ADD ./run_container.sh /etc/boinc-client

VOLUME ${BOINC_HOME}
WORKDIR ${BOINC_HOME}

ENTRYPOINT ["/etc/boinc-client/run_container.sh"]

EXPOSE 31416
CMD ["boinc", "--allow_remote_gui_rpc"]
