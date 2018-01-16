# Script for PostgreSQL setup Primary-Slave with Streaming replication

Executes the following query on the slave server to check when was the last replay and if the recovery is in progress and sends email if the replay was replayed more than ALLOWED_DELAY time ago.
Be sure to edit the constants - ```ALLOWED_DELAY, EMAIL, PSQL_PARAMS```

You can set it up as a cron job. There are two versions of script - in Bash and ruby.
Bash script depends on the psql and should be executed on the replica server.
Ruby script depends on pg and yaml gems, but it can read the database connection string from conf file and connect to the replica from any server that has access to it.

```sql
SELECT now() - pg_last_xact_replay_timestamp() AS replication_delay, pg_is_in_recovery();
```

