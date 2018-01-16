WAZZUP?
=======

A simple-like-a-stick single-host docker installation of BOINC client.

WORKS ON
========

Anything with a docker-machine and docker-compose installed.


WHY?
====

Because I needed to a) run me a BOINC in a tiny controlled instance
and b) exercise me a docker.

Arm64v8 note
============

Since `v0.0.14-arm64v8` we can run *armhf aka arm32v7* applications!

LICENSE
=======

MIT

DOCS
====

See the Dockerfiles. Here's the compose file example:

```text
version: '3.4'

x-custom:
  &default-image
  image: 'argentoff/boinc:v0.0.13-arm32v7'

secrets:
  boinc_gui_password:
    external: true

volumes:
  boinc-data-1:
    driver: nfs
    driver_opts:
      share: nas.ag.lan:/volumeUSB1/usbshare/homelab/netshare-storages/boinc-data-1

services:
  cruncher_1:
    <<: *default-image
    environment:
      TIMEZONE: Europe/Moscow
    volumes:
      - boinc-data-1:/var/lib/boinc-client
    ports:
      - target: 31416
        published: 31416
        mode: host
    secrets:
      - boinc_gui_password
    deploy:
      mode: replicated
      replicas: 1
      placement:
        constraints:
          - node.labels.net.argentoff.boinc.cruncher == 1
      restart_policy:
        delay: 10s
        max_attempts: 3
        window: 120s
      update_config:
        delay: 10s
```

GUI PASSWORD SECRET NOTE
========================

Gui RPC password is read at container startup from the file specified in
`BOINC_GUI_PASSEORD_FILE` environment variable. Default file location (variable value)
is `/run/secrets/boinc_gui_passwords`.

Public Docker images are here: [argentoff/boinc](https://hub.docker.com/r/argentoff/boinc/)
