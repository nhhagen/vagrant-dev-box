mongodb_repo:
  pkgrepo.managed:
    - humanname: MongoDB Source
    - name: deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.0 multiverse
    - dist: trusty/mongodb-org/3.0
    - file: /etc/apt/sources.list.d/mongodb.list
    - keyid: 7F0CEB10
    - keyserver: keyserver.ubuntu.com

mongodb-org:
  pkg:
    - latest
    - require:
      - pkgrepo: mongodb_repo
mongod:
  service:
      - running
      - enable: True
      - require:
          - pkg: mongodb-org
