function setup {
  cd $1

  git remote remove origin
  git remote add origin $2

  rm setup.sh
  echo -e "# ${1}\n\tgit clone --recursive $2" > README.markdown

  git add -A .
  git commit -m "Initial commit"
  git push --set-upstream origin master
}

git clone --recursive https://github.com/nhhagen/vagrant-dev-box.git $1 &&
  setup $1 $2

