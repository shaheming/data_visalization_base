#!/bin/bash


cd /root/decisionTree
bundle check || bundle install
bin/rails db:create || echo "database already exit"
bin/rails db:migrate || echo "no migrate is needed"




if [ -f tmp/pids/server.pid ]; then
  rm -f tmp/pids/server.pid
fi


if [  "$RAILS_ENV" = "production" ]
then
    echo "==================== start decision tree server in production environment ===================="
    make -i production_start_all
elif [  "$RAILS_ENV" = "development" ]
	then
    echo "==================== start decision tree server in development environment ===================="
    make -i development_start_all
fi





