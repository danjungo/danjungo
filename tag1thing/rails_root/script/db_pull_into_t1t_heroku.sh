#!/bin/bash

# script/db_pull_into_t1t_heroku.sh

# copies data from heroku into db: t1t_heroku

# rvm ruby-1.8.7-p174%taps

# gems I depend on:
# gem install postgres
# gem install heroku
# gem install taps

# heroku db:pull postgres://maco@localhost/t1t_heroku

# psql t1t_heroku

# select count(*) from usrs;
# select count(*) from uurls;

