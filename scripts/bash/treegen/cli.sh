#!/usr/bin/env bash

# Get the directory of this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)";
SCRIPT_VERSION="v1.sh";
SCRIPT_FILE="$SCRIPT_DIR/$SCRIPT_VERSION";

# echo -e "\n$SCRIPT_DIR\n$SCRIPT_FILE"; # -e interpret escape sequences

# Check if v1.sh exists
if [[ ! -f "$SCRIPT_FILE" ]]; then
    echo "Error: work file not found at $SCRIPT_FILE";
    exit 1;
fi

# Run v1.sh with all arguments, propagate its exit code
"$SCRIPT_FILE" "$@";
exit $?; # $? holds the exit code of the last command executed
