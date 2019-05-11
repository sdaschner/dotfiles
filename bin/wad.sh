#!/bin/bash
set -euo pipefail

watchDir=./src/main
pom=pom.xml
dest=/tmp/wad-dropins/

function watchChanges() {
  inotifywait -r -e modify ./src/main 2> /dev/null
}

function buildAndCopy() {
  echo -n "building..."
  mvn package > /dev/null &
  mvnPID=$!
  code=0
  wait $mvnPID || code=$?
  if [[ "$code" = "0" ]]; then
    echo -e " success \u2713"
    copyWAR
  else
    echo -e " build failed \u2718"
  fi
}

function copyWAR() {
  echo "copying $(ls target/*.war) to $dest"
  cp target/*.war $dest
}

if [[ ! -d $watchDir || ! -e $pom ]]; then
  echo "Usage: ${0##*/} \n needs to be executed in a Maven project" exit 2
fi

buildAndCopy
while true; do
  echo "setting up file watches for $watchDir"
  watchChanges
  buildAndCopy
done
