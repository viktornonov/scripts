#!/usr/bin/env ruby

# Sends alert when your replica is the allowed_delay minutes behind the primary server
# Expected format of the db.yml file
# db_standby:
#   host: 1.1.1.1
#   database: drop
#   username: table
#   password: students
#   port: 1234

require 'pg'
require 'yaml'

DATABASE_CONFIG = '/path/to/your/db.yml'
EMAIL_TO_NOTIFY = 'your@email.com'
ALLOWED_DELAY = 20


db_config = YAML.load_file(DATABASE_CONFIG)['db_standby']
conn = PG::Connection.open(host: db_config['host'], dbname: db_config['database'], user: db_config['username'], password: db_config['password'], port: db_config['port'])
res = conn.exec 'select now() - pg_last_xact_replay_timestamp() as replication_delay, pg_is_in_recovery();'
delay = res.values[0][0] #00:00:00.123123
minutes_delay = delay.match(/\d{2}:(\d{2}):\d{2}\.\d{6}/)[1].to_i
if minutes_delay > ALLOWED_DELAY
  `echo 'yup that sucks' | mail -s 'replication is behind with #{delay}' #{EMAIL_TO_NOTIFY}`
end


