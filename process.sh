#!/bin/bash

setup_git() {
  git config --global user.email "travis@travis-ci.org"
  git config --global user.name "Travis CI"
  git config --global github.token ${GH_TOKEN}
  git config credential.helper "store --file=.git/credentials"
  echo "https://${GH_TOKEN}:@github.com" > .git/credentials
}

commit_files() {
    git checkout -qf master
    wget -O Ct-WI-Strain-Info.tsv "https://docs.google.com/spreadsheets/d/1mqXOlUX7UeiPBe8jfAwFZnqlzhb7X-eKGK_TydT7Gx4/export?format=tsv&id=1mqXOlUX7UeiPBe8jfAwFZnqlzhb7X-eKGK_TydT7Gx4&gid=1642815395"
    git add Ct-WI-Strain-Info.tsv
    git remote add origin https://${GH_TOKEN}@github.com/C.-tropicalis-Strain-Sheet/resources.git > /dev/null 2>&1
    git commit --message "Travis build: ${TRAVIS_BUILD_NUMBER}"
    if [[ $? -eq 0 ]]; then
        git push --set-upstream origin master
    fi;
}

setup_git
commit_files
