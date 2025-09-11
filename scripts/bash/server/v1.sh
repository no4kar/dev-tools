#!/usr/bin/env bash

PORT=3005
ADDRESS="0.0.0.0"

function fatal(){
  echo '[fatal error]' "$@" >&2; # $@ -> expands to all positional parameters, >&2 -> prints goes to stderr(2), not stdout(1)
  exit 1;
}

enable accept || fatal "can't load the \"accept\"";
