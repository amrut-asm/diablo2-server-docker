#!/bin/bash
export D2GS_DIR="/root/.wine/drive_c/Program Files/d2gs"
cd "$D2GS_DIR"
envsubst < d2gs.reg.template > d2gs.reg
rm d2gs.reg.template