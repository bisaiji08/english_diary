#!/bin/bash

# Redisの起動
redis-server --daemonize yes

# cronの起動
service cron start

# Railsサーバーの起動
rm -f tmp/pids/server.pid
bundle exec rails server -b 0.0.0.0 -p 3000
