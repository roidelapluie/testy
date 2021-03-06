#!/bin/bash

set -e

rm -rf _book||true

gitbook build

echo ${TRAVIS_SECURE_ENV_VARS}
[[ "${TRAVIS_SECURE_ENV_VARS}" == "true" ]]

cd _book
git init .
git config user.name "Travis"
git config user.email "packaginglove@roidelapluie.be"
git add .
git commit -m "Deploy to GitHub Pages"

echo ${GH_URL}

git push -f --quiet "https://${GH_TOKEN}@${GH_URL}" master:gh-pages > /dev/null 2>&1


