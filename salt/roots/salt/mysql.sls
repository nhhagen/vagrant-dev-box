mysql-client:
  pkg.latest

mysql-server:
  pkg.latest

python-mysqldb:
  pkg.latest

mysql_service:
  service:
    - name: mysql
    - running
    - enable: True
    - reload: True
    - require:
      - pkg: mysql-server

# Examples
# To create a db see: http://docs.saltstack.com/en/latest/ref/states/all/salt.states.mysql_database.html
# <database name>:
#   mysql_database.present:
#     - character_set: utf8
#     - collate: utf8_danish_ci
#     - require:
#       - pkg: python-mysqldb
#       - service: mysql_service

# To create mysql users see: http://docs.saltstack.com/en/latest/ref/states/all/salt.states.mysql_user.html
# <username>:
#   mysql_user.present:
#     - host: '%'
#     - password: <password>
#     - require:
#       - service: mysql_service
#       - pkg: python-mysqldb
#       - mysql_database: <database name>


# To set grants see: http://docs.saltstack.com/en/latest/ref/states/all/salt.states.mysql_grants.html
# <grant name>:
#   mysql_grants.present:
#     - grant: all
#     - database: <database name>.*
#     - user: <username>
#     - host: '%'
#     - require:
#       - service: mysql_service
#       - pkg: python-mysqldb
#       - mysql_user: <username>
#       - mysql_database: <database name>
