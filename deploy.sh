#!/usr/bin/env sh

set -e 

npm run build

cd dist

git init
 
git add

git commit -m "New deployment"

git commit -m "New deployment"

git push -f git@github.com:msatrionn/todo_list.git master:gh-pages