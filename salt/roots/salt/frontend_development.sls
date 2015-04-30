include:
  - nodejs
  - ruby

packages:
  npm.installed:
    - pkgs:
      - gulp
      - grunt
      - bower
      - deployd
    - require:
      - sls: nodejs
  gem.installed:
    - names:
      - sass
      - compass
    - require:
      - sls: ruby
