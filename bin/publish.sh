#!/usr/bin/env bash

# directory of this script
DIR="$( cd "$( dirname "$0" )" && pwd )"
echo "$DIR"
cd $DIR/../

# build
grunt build || { echo 'Build failed'; exit 1; }

# checkout new branch
WORKING_BRANCH="$(git rev-parse --abbrev-ref HEAD)"
IS_STASHED=[ $(git stash) = "No local changes to save" ]
git checkout --orphan build
git reset --hard $WORKING_BRANCH

# add all files in the dist dir to branch at root level
FILES="$(ls dist)"

mv dist/* ./ -b

git rm -rf .
for file in "$FILES"; do
  git add $file -f
  if [ -e $file~ ]; then
    if [ -d $file ]; then
      rm -rf $file
    else
      rm $file
    fi
    mv $file~ $file
  fi
done

git commit -m "Built $(date) : $(git log | head -1)"

# push to gh-pages
git push origin build:gh-pages -f

# return to working branch
git checkout $WORKING_BRANCH
git reset --hard HEAD
if [ $IS_STASHED ]; then git stash pop; fi
git branch -D build
