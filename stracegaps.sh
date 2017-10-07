#!/bin/bash

if [[ $# -ne 2 ]]
then
  echo "Usage: $0 <strace.log> <threshold>"
  echo "strace -t -T -o strace.log"
  exit 1
fi

format="%H:%M:%S"
last=0
current=0

while read linefull
do
  line=${linefull:0:8}
  current=$( date -d "$line" +"%s" )
  if [[ last -eq 0 ]]
  then
    last=$current;
  fi
  gap=$(( current - last ))
  if [[ $gap -gt $2 ]]
  then
    echo "$( date -d "@$last" +"$format") -> $( date -d "@$current" +"$format" ) = $gap seconds"
    echo $linelast;
    echo $linefull;
  fi
  linelast=$linefull;
  last=$current
done < $1
