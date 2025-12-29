#!/usr/bin/env bash
# booklet.sh
# Usage: ./booklet.sh ratio=8 pages=8

set -euo pipefail

# default values (optional)
RATIO=4
PAGES=4

# parse args of form name=value
for ARG in "$@"; do
  case $ARG in
    ratio=*) RATIO=${ARG#*=} ;;
    pages=*) PAGES=${ARG#*=} ;;
    *) echo "Unknown arg: $ARG"; exit 1 ;;
  esac
done

# validate numeric
if ! [[ $RATIO =~ ^[0-9]+$ ]] || ! [[ $PAGES =~ ^[0-9]+$ ]]; then
  echo "ratio and pages must be integers" >&2
  exit 1
fi

# ratio must be multiple of 4
if (( RATIO % 4 != 0 )); then
  echo "ratio must be a multiple of 4 (e.g. 4,8,12...)" >&2
  exit 1
fi

# compute padding to a multiple of ratio
if (( PAGES % RATIO == 0 )); then
  PADDED=$PAGES
else
  PADDED=$(( ( (PAGES + RATIO - 1) / RATIO ) * RATIO ))
fi

SHEETS_PER_SIG=$(( RATIO / 4 ))

# function to join array by comma
join_by_comma() {
  local IFS=,
  echo "$*"
}

sig_index=0
while (( sig_index < PADDED )); do
  offset=$sig_index            # zero-based offset into document (0..)
  S=$RATIO

  front=()
  back=()

  # For each physical sheet in the signature
  for (( i=0; i<SHEETS_PER_SIG; i++ )); do
    # local numbers within signature (1..S)
    left_front_local=$(( S - 2*i ))
    right_front_local=$(( 1 + 2*i ))
    left_back_local=$(( 2 + 2*i ))
    right_back_local=$(( S - 1 - 2*i ))

    # convert to global page numbers (offset + local)
    lf=$(( offset + left_front_local ))
    rf=$(( offset + right_front_local ))
    lb=$(( offset + left_back_local ))
    rb=$(( offset + right_back_local ))

    # If any page > original PAGES, mark as blank
    [[ $lf -gt $PAGES ]] && lf="blank"
    [[ $rf -gt $PAGES ]] && rf="blank"
    [[ $lb -gt $PAGES ]] && lb="blank"
    [[ $rb -gt $PAGES ]] && rb="blank"

    front+=("$lf" "$rf")
    back+=("$lb" "$rb")
  done

  # Print result for this signature
  # Flatten each signature into single-line comma-separated lists
  echo "Signature starting at page $(( offset + 1 )) (pages $(( offset+1 )) - $(( offset+S ))):"
  echo -n "Front: "
  join_by_comma "${front[@]}"
  echo
  echo -n "then flop"
  echo
  echo -n "Back:  "
  join_by_comma "${back[@]}"
  echo
  echo

  sig_index=$(( sig_index + S ))
done

exit 0
