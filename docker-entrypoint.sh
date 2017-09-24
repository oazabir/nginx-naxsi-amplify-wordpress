#!/bin/sh

sudo -u nginx python /usr/bin/nginx-amplify-agent.py start \
                   --config=/etc/amplify-agent/agent.conf \
                   --pid=/var/run/amplify-agent/amplify-agent.pid


if test "x${1:0:1}" = "x-" 
then
    exec nginx "$@"
else
    exec "$@"
fi

