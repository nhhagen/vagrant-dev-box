# Include the ``jdk`` sls in order to use oracle_java_pkg
include:
  - jdk

# Note: this is only valid for the Debian repo / package
# You should filter on grain['os'] conditional for yum-based distros
elasticsearch_repo:
  pkgrepo.managed:
    - humanname: Elasticsearch Official Debian Repository
    - name: 'deb http://packages.elasticsearch.org/elasticsearch/2.x/debian stable main'
    - dist: stable
    - key_url: salt://elasticsearch/GPG-KEY-elasticsearch
    - file: /etc/apt/sources.list.d/elasticsearch.list
    - require_in:
      pkg: elasticsearch

/etc/elasticsearch/elasticsearch.yml:
  file.managed:
    - source:
      - salt://elasticsearch/elasticsearch.yml
    - group: elasticsearch
    - require:
      - pkg: elasticsearch

elasticsearch:
  pkg:
    - latest
    - refresh: True
    - require:
      - sls: jdk
  service:
    - running
    - enable: True
    - require:
      - pkg: elasticsearch
    - watch:
      - pkg: elasticsearch
    - watch:
      - file: /etc/elasticsearch/elasticsearch.yml

