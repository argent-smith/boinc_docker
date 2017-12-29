FROM arm64v8/debian:stretch-slim

LABEL maintainer="argent_smith (argentoff@gmail.com)"

ENV GOSU_VERSION=1.7
RUN set -x \
    && apt-get update \
    && apt-get dist-upgrade -y \
    && apt-get install \
       -y \
       --no-install-recommends gpg \
       dirmngr \
       ca-certificates wget \
    && rm -rf /var/lib/apt/lists/* \
    && wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture)" \
    && wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture).asc" \
    && export GNUPGHOME="$(mktemp -d)" \
    && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
    && gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
    && sleep 10 \
    && rm -rf "$GNUPGHOME" /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu \
    && gosu nobody true \
    && apt-get purge -y --auto-remove ca-certificates wget gpg

RUN dpkg --add-architecture armhf \
    && apt-get update \
    && apt-get install -y locales \
                          libstdc++6 \
                          freeglut3 \
                          boinc-client \
                          boinctui \
                          binutils:armhf \
                          libstdc++6:armhf \
                          libstdc++6-armhf-cross \
                          libc6-armhf-cross \
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

ENV BOINC_HOME=/var/lib/boinc-client \
    BOINC_USER=boinc \
    BOINC_GROUP=boinc

ADD ./run_container.sh /etc/boinc-client
ADD ./files/cc_config.xml /etc/boinc-client

VOLUME ${BOINC_HOME}
WORKDIR ${BOINC_HOME}

ENTRYPOINT ["/etc/boinc-client/run_container.sh"]

EXPOSE 31416
CMD ["boinc", "--allow_remote_gui_rpc"]
