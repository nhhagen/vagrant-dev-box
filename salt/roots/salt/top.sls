# Comment in/out the software you want
# When enabling servers remember to forward ports in ../../../Vagrantfile

base:
  '*':
    - tools
    - python
    - ruby
    - nodejs
    # - jdk
    # - frontend_development # requires 'nodejs', 'ruby'
    # - elasticsearch # requires 'jdk'
    # - rabbitmq
    # - mysql
    # - mongodb
