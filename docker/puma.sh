#!/bin/sh
set -e
LOG=/var/log/puma.log

cd /app
date >> $LOG

bundle exec rake db:migrate 2>&1 | tee -a $LOG
bundle exec puma -p $PORT -e $RAILS_ENV 2>&1 | tee -a $LOG

