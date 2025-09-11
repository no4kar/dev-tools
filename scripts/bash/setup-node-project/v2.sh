#!/usr/bin/env bash

# (-e) exit on error, (-u) undefined variables, (-o pipefail) pipeline errors
set -euo pipefail

# === CONFIGURATION ===
LOG_FILE="./setup-node-project-2.log"

# === FUNCTIONS ===
log() {
  echo -e "[INFO] $*" | tee -a "$LOG_FILE"
}

error_exit() {
  echo -e "[ERROR] $*" | tee -a "$LOG_FILE" >&2
  exit 1
}

# === SCRIPT START ===

gitRepURL="${1:-}"
if [[ -z "$gitRepURL" ]]; then
  error_exit "Usage: $0 <git-repo-url>"
fi

log "Cloning repository: $gitRepURL"
echo -e "\n\t*** ${gitRepURL} ***"

# Show current directory
log "Current working directory: $(pwd)"

# Clone repository
if ! git clone "$gitRepURL"; then
  error_exit "Failed to clone repository: $gitRepURL"
fi

# List directory contents
ls -F -l -a | tee -a "$LOG_FILE"

# Extract project folder name
regex="^.*\/([0-9a-zA-Z_-]+)\.git$"

if [[ "$gitRepURL" =~ $regex ]]; then
  repoName="${BASH_REMATCH[1]}"
  projectFolder="./$repoName"

  log "Detected project folder: $projectFolder"

  if [[ ! -d "$projectFolder" ]]; then
    error_exit "Expected project folder not found: $projectFolder"
  fi

  cd "$projectFolder"
  log "Changed to project directory: $(pwd)"

  read -p "PAUSE - Press enter to continue..."

  log "Running npm install..."
  npm install | tee -a "$LOG_FILE"

  log "Creating and switching to 'develop' branch..."
  git switch -c develop

  log "Opening project in VS Code..."
  code -n .

  log "Setup complete."
else
  error_exit "Failed to extract project folder name from URL: $gitRepURL"
fi
