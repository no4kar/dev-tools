#!/usr/bin/env bash

if [[ ! -f "./v1.sh" ]]; then
    echo "Error: work file not found."
    exit 1
fi

# echo "$@"
./v1.sh "$@" # Run v1.sh with all arguments, propagate its exit code
exit $? # $? holds the exit code of the last command executed
