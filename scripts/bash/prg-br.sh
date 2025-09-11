#!/usr/bin/env bash

function clr-line(){
  # \r → moves cursor to start of line
  # \033[K (or \e[K) → clears everything to the right of the cursor\
  # -n → suppresses the newline at the end.
  # -e → tells echo to interpret backslash escapes (like \r, \n, \t).
  echo -ne "\r\033[K";
}

function progress-bar(){
  local from=$1;
  local to=$2;

  echo -ne "wait a few seconds to start from ${from} to ${to}\n";
  sleep 2

  clr-line;

  local i;
  for ((i = from; i < to; i++)); do
    echo -ne "\r${i}";
    sleep 0.05;
  done

  clr-line;

  echo -ne "that is it";
  sleep 2;
}

progress-bar 16 87;

exit 0;
