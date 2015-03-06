node_repo:
  cmd.run:
    - name: curl -sL https://deb.nodesource.com/setup_0.12 | bash -

nodejs:
  pkg:
    - latest
    - require:
      - cmd: node_repo
