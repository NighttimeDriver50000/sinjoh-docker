#!/bin/sh
flashplayerdebugger "$@" &
pid=$!
trap "kill -9 $pid" INT TERM EXIT
tail --pid=$pid -f /dev/null
