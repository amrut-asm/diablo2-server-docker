#!/bin/bash
set -eux
cp -r templates/data generated
envsubst < templates/pvpgn/address_translation.conf.template    > generated/data/etc/address_translation.conf
envsubst < templates/pvpgn/bnetd.conf.template                  > generated/data/etc/bnetd.conf
envsubst < templates/pvpgn/d2cs.conf.template                   > generated/data/etc/d2cs.conf
envsubst < templates/pvpgn/d2dbs.conf.template                  > generated/data/etc/d2dbs.conf
envsubst < templates/pvpgn/realm.conf.template                  > generated/data/etc/realm.conf
envsubst < templates/docker-compose.yml.template                > generated/docker-compose.yml