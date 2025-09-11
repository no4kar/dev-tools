#! /usr/bin/bash
gitRepURL=$1
printf "\\n\\t%s\\n" "***${gitRepURL}***"

pwd
git clone $gitRepURL
ls -F -l -a

regex="^.*\/([0-9a-zA-Z_-]+)\.git$"

if [[ $gitRepURL =~ $regex ]]; then
  printf "\\n\\t%s\\n\\t%s" "${BASH_REMATCH[0]}" "${BASH_REMATCH[1]}"
  projectFolder="./${BASH_REMATCH[1]}/"
  printf "\\n\\n\\t%s\\n" "project folder is ${projectFolder}"
  cd $projectFolder
  pwd
  read -p "PAUSE"
  npm install
  git switch -c develop
  pwd
  code -n .

else
  pwd
  printf "\\n\\t%s\\n" "error -> if [[ $gitRepURL =~ $regex ]]"
fi

#read -p "PAUSE"
#read -p "Enter project folder name for VSC: " projectFolderName
#code $projectFolderName
