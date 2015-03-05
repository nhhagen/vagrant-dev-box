node_repo:
  cmd.run:
    - name: curl -sL https://deb.nodesource.com/setup | bash -

nodejs:
  pkg.latest:
    - cmd: node_repo
