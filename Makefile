clean_dev:
	echo > log/development.log

clean_sid:
	echo > log/sidekiq.log

clean_all: clean_dev clean_sid

sidekiq_stop:
	sidekiqctl stop tmp/pids/sidekiq.pid

sidekiq_start:make_pids_dir
	bundle exec sidekiq -d

rails_stop:
	kill $(shell cat tmp/pids/server.pid)

sidekiq_restart:
	sidekiqctl stop tmp/pids/sidekiq.pid
	bundle exec sidekiq -d

make_pids_dir:
	mkdir -p tmp/pids

development_start_all:export RAILS_ENV=development
development_start_all:sidekiq_restart
	rails s -p $(PORT) -b $(SERVER_HOST)


production_start_all:export RAILS_ENV=production
production_start_all:sidekiq_restart
	rails s -p $(PORT) -b $(SERVER_HOST)

production_restart_all:export RAILS_ENV=production
production_restart_all:sidekiq_restart rails_stop
	rails s -p $(PORT) -d

stop_all:sidekiq_stop rails_stop

training_test_db:
	rails ml_server_test:init_tree_db

test_port:
	echo $(PORT)

test_a:
	echo PORT