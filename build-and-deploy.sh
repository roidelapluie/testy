#!/bin/bash
set -e
rm -rf _book||true
gitbook build
if [[ "${TRAVIS_SECURE_ENV_VARS}" == "false" ]]; then
    exit 0
fi
cd _book
git init .
git config user.name "Travis"
git config user.email "packaginglove@roidelapluie.be"
git add .
git commit -m "Deploy to GitHub Pages"
git push -f --quiet "https://${GH_TOKEN}@${GH_URL}" master:gh-pages > /dev/null 2>&1
