#/usr/bin/env bash
function setup {
  mkdir $2
  cp -r . $2
  cd $2

  rm -rf .git
  rm setup.sh
  rm LICENSE
  echo "# ${2}\n\tgit clone $1" > README.markdown

  git init
  git remote add origin $1

  git add -A .
  git commit -m "Initial commit"
  git push --set-upstream origin master
}

setup $@
cd $2
