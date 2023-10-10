#!/usr/bin/dumb-init /bin/sh

nohup crond -f &

nohup /app/hello &
