#!/usr/bin/env bash

# directory of this script
DIR="$( cd "$( dirname "$0" )" && pwd )"
cd $DIR

# build
grunt build

# checkout new branch
WORKING_BRANCH="$(git rev-parse --abbrev-ref HEAD)"
git checkout -b build

# delete all but build directory
rm -rf !(dist|.git)
mv dist/* ./
rmdir dist

# add and commit
git add *
git commit -m "Built $(date) : $(git log | head -1)"

# push to github :gh-pages
git push origin build:gh-pages

git checkout $WORKING_BRANCH
git branch -D build 
