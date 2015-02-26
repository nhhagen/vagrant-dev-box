#
# How to install automatically Oracle Java JDK under Salt Stack
#
# Thanks Oracle for complicating things :(
#
# 1. Create a java/ folder in your salt master
# 2. Paste this file in init.sls
# 3. salt '*' state.sls java
#
# Source:
#  * https://github.com/log0ymxm/salt-jvm/blob/master/init.sls
#  * http://architects.dzone.com/articles/puppet-installing-oracle-java
#
oracle-ppa:
  pkgrepo.managed:
    - humanname: WebUpd8 Oracle Java PPA repository
    - ppa: webupd8team/java

oracle-license-select:
  cmd.run:
    - unless: which java
    - name: '/bin/echo /usr/bin/debconf shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections'

oracle-license-seen-lie:
  cmd.run:
    - name: '/bin/echo /usr/bin/debconf shared/accepted-oracle-license-v1-1 seen true  | /usr/bin/debconf-set-selections'
    - require:
      - cmd: oracle-license-select

# oracle-java7-installer:
#   pkg:
#     - installed
#     - require:
#       - pkgrepo: oracle-ppa
#       - cmd: oracle-license-seen-lie

oracle-java8-installer:
  pkg:
    - latest
    - require:
      - pkgrepo: oracle-ppa
      - cmd: oracle-license-seen-lie

# maven:
#   pkg.installed
