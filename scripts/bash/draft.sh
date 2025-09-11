#!/usr/bin/env bash

echo -e 'echo "$$ $#" "$*"' \
  '\n\t=>' \
  "$$ $# $*";

name="nike";
echo "${name}";
echo "$(realpath ".")";

echo -e 'echo "${BASH_SOURCE[0]}"' \
  '\n\t=>' \
  "${BASH_SOURCE[0]}";

echo -e 'echo "$(dirname "${BASH_SOURCE[0]}")"' \
  '\n\t=>' \
  "$(dirname "${BASH_SOURCE[0]}")";

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)";
echo "$SCRIPT_DIR"

exit 0
