#!/bin/bash
set -e

if [ "${1:0:1}" = '-' ]; then
    set -- boinc "$@"
fi

if [ "$1" = 'boinc' ]; then
    mkdir -p ${BOINC_HOME}
    chmod 700 ${BOINC_HOME}
    chown -R ${BOINC_USER}:${BOINC_GROUP} ${BOINC_HOME}

    cd ${BOINC_HOME}
    exec gosu ${BOINC_USER} "$@"
fi

exec "$@"
