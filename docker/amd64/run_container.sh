#!/bin/bash
set -e

if [ "${1:0:1}" = '-' ]; then
    set -- boinc "$@"
fi

BOINC_GUI_PASSWORD_FILE=${BOINC_GUI_PASSWORD_FILE:-/run/secrets/boinc_gui_password}

if [ "$1" = 'boinc' ]; then
    if [ ! "$(cat /etc/timezone)" = "${TIMEZONE}" ]; then
        ln -sf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime
    fi

    cat ${BOINC_GUI_PASSWORD_FILE} > /etc/boinc-client/gui_rpc_auth.cfg

    mkdir -p ${BOINC_HOME}
    chmod 755 ${BOINC_HOME}
    chown -R ${BOINC_USER}:${BOINC_GROUP} ${BOINC_HOME}

    cd ${BOINC_HOME}
    exec gosu ${BOINC_USER} /bin/sh -c "$*"
fi

exec "$@"
