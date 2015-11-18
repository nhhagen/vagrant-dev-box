node_repo:
  cmd.run:
    - name: curl -sL https://deb.nodesource.com/setup_4.x | bash -

nodejs:
  pkg:
    - latest
    - require:
      - cmd: node_repo
