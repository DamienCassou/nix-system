#!/usr/bin/env bash

LOCAL_PORT=8385
REMOTE_PORT=8384 # official syncthing default port

echo You may now open a browser on http://localhost:${LOCAL_PORT}
ssh -L ${LOCAL_PORT}:127.0.0.1:${REMOTE_PORT} -N  raspberrypi
