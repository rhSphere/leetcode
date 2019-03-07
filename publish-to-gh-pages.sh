#!/bin/bash
set -ev
git clone https://${GH_REF} .deploy_git
cd .deploy_git
git checkout master
cd ../
mv .deploy_git/.git/ ./public/
cd ./public
git config user.name  "rhsphere"
git config user.email "rhsphere@gmail.com" 
# add commit timestamp
git add .
git commit -m "traviscibot commit at `date +"%Y-%m-%d %H:%M"`"
git push --force --quiet "https://${Travis_gh_token}@${GH_REF}" master:master
