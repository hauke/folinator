#!/bin/bash

rm db/development.sqlite3 db/test.sqlite3 public/uploads/ -rf
bundle exec rake db:migrate
bundle exec rake db:seed
bundle exec rake db:test:prepare
