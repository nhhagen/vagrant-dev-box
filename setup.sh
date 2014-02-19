function setup {
  cd $2

  git remote remove origin
  git remote add origin $1

  rm setup.sh
  rm LICENSE
  echo -e "# ${2}\n\tgit clone --recursive $1" > README.markdown

  git add -A .
  git commit -m "Initial commit"
  git push --set-upstream origin master
}

git clone --recursive https://github.com/nhhagen/vagrant-dev-box.git $2 &&
  setup $@

