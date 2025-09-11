#!/bin/bash

# Default values
ROOT="."
EXCLUDES=".*\(node_modules\|\.git\|\.vscode\|__test__\).*"

# Parse CLI-style arguments
# const argv = process.argv.slice(2)
while [[ $# -gt 0 ]]; do # $# === argv.length
  case "$1" in
  --root=*)
    ROOT="${1#*=}"
    shift
    ;;

  --exclude=*)         # matches any string that starts with '--exclude=', followed by anything (including nothing)
    EXCLUDES="${1#*=}" # `${VAR#pattern}` does remove shortest prefix. If $1 is '--exclude=tmp', then ${1#*=}=tmp
    shift              # argv.shift()
    ;;

  *)
    echo "Unknown option: $1"
    exit 1
    ;;
  esac
done

# Make sure ROOT is absolute
ROOT="$(realpath "$ROOT")"

# Find all files and directories, excluding undesired paths
find "$ROOT" -not -regex "$EXCLUDES" | \
  awk '
  BEGIN {
    FS = "/"
    base_depth = 0 # Will store the depth of the root path
  }
  
  # Main block: Read all paths into memory and calculate relative depth
  {
    if (base_depth == 0) {
      # For the first line, establish the depth of our root directory.
      # This normalizes all subsequent depth calculations.
      base_depth = NF
    }
    
    path[NR] = $0
    # The new depth is relative to the root path (e.g., root is depth 1)
    depth[NR] = NF - base_depth + 1
    lastRow = NR
  }

  # END block: All paths have been read, now generate the tree
  END {
    for (i = 1; i <= lastRow; i++) {
      # The root element (depth 1) has no prefix.
      # All children (depth > 1) need a prefix.
      prefix = ""
      if (depth[i] > 1) {
        # Loop to build the prefix for all parent levels
        for (j = 1; j < depth[i]; j++) {
          isLastBranch = 1
          # Look ahead to see if there are more items in this parent branch
          for (k = i + 1; k <= lastRow; k++) {
            if (depth[k] == j) {
              isLastBranch = 0 # Found a sibling branch, so this branch is not the last
              break
            }
            if (depth[k] < j) {
              break
            }
          }
          prefix = prefix (isLastBranch ? "    " : "│   ")
        }
      }

      # Determine the connector for the current item itself ("├──" or "└──")
      isLastItem = 1
      # Look ahead to see if this is the last item among its direct siblings
      for (k = i + 1; k <= lastRow; k++) {
        if (depth[k] == depth[i]) {
          isLastItem = 0 # Found another item at the same depth, so not the last
          break
        }
        if (depth[k] < depth[i]) {
          break # Moved to a shallower level, so this must have been the last
        }
      }
      
      # The root element doesnt get a connector, children do.
      if (depth[i] > 1) {
          connector = isLastItem ? "└── " : "├── "
      } else {
          connector = ""
      }
      
      # For printing, we want the basename (the last part of the path)
      # The split() function returns the number of elements created.
      # So, path_parts[n] gives us the last element.
      n = split(path[i], path_parts, "/")
      basename = path_parts[n]

      # For the root, print the original full path. For children, print the basename.
      if (depth[i] == 1) {
        print path[i]
      } else {
        print prefix connector basename
      }
    }
  }
'

exit 0
