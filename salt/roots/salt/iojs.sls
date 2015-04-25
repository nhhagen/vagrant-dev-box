# If you want to use iojs states that requires nodejs must be updated to require
# iojs

iojs_repo:
  cmd.run:
    - name: curl -sL https://deb.nodesource.com/setup_iojs_1.x | bash -

iojs:
  pkg:
    - latest
    - require:
      - cmd: iojs_repo
