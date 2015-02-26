# Include the ``java`` sls in order to use oracle_java_pkg
include:
    - jdk

# Note: this is only valid for the Debian repo / package
# You should filter on grain['os'] conditional for yum-based distros
elasticsearch_repo:
    pkgrepo.managed:
        - humanname: Elasticsearch Official Debian Repository
        - name: deb http://packages.elasticsearch.org/elasticsearch/1.4/debian stable main
        - dist: stable
        - key_url: salt://elasticsearch/GPG-KEY-elasticsearch
        - file: /etc/apt/sources.list.d/elasticsearch.list

elasticsearch:
    pkg:
        - latest
        - require:
            - sls: jdk
            - pkgrepo: elasticsearch_repo
    service:
        - running
        - enable: True
        - require:
            - pkg: elasticsearch

