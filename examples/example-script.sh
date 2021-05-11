#!/bin/bash
set -euo pipefail
cd ${0%/*}
PIDFILE=./script.pid


# example script to show
# - traps
# - PID files
# - pipe xargs
# - waiting for HTTP health check
# - number formatting with leading zeros: 01..10


function cleanup() {
  echo stopping container
  docker stop hello &> /dev/null || true
	rm $PIDFILE
}

#  PID file
if [[ -f $PIDFILE ]]; then
  pid=$(cat $PIDFILE)
  ps -p $pid > /dev/null 2>&1
  if [ $? -eq 0 ]; then
    echo "Script is already running"; exit 1
  else
    # process not found, overwrite
    echo $$ > $PIDFILE;
  fi
else
	# wasn't running, write pid
  echo $$ > $PIDFILE;
fi

# after PID file has been set
trap cleanup EXIT


# creates file01.txt, ..., file10.txt
for i in {1..10}; do
  num=$(printf '%02d' $i)
  echo "Hello $i" > file_$num.txt;
done

# useful for actions
ls *.txt | xargs -I1 echo doing something with 1


docker run --rm -d \
  --name hello \
  -p 80:80 \
  nginxdemos/hello:0.2-plain-text

echo waiting for startup
while [[ "$(curl -s -o /dev/null -w ''%{http_code}'' http://localhost/)" != "200" ]]; do
  sleep 0.5;
done

sleep 2
echo accessing localhost
curl http://localhost/
