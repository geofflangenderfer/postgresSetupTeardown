## Why did you do this?
calling `psql` commands by hand was taking ~1.25 hours to grade an assignment. It took ~10 hours to write this, but grading an assignment now takes ~0.33 hours

## What is this?
These scripts use psql and bash to automate:
- database setup
- creating tables
- loading data from csv
- querying tables
- database teardown

## How can I use this?
- install postgres[2]
- [start postgres server][1]
```bash
$ postgres -D /usr/local/pgsql/data >logfile 2>&1 &
```
- [set postgres user password][0] to 'password'
```bash
$ sudo -u postgres psql
postgres=# ALTER USER postgres PASSWORD 'postgres';
ALTER ROLE
```
- check that student table names coincide with `loadData`
```bash
# testQueries.sh
...
loadData() {
  psql -c "\copy *departments* from '$1/departments.csv' with (format csv, header true);" $testDbLogin
  psql -c "\copy *employees* from '$1/employees.csv' with (format csv, header true);" $testDbLogin
  psql -c "\copy *dept_emp* from '$1/dept_emp.csv' with (format csv, header true);" $testDbLogin
  psql -c "\copy *dept_manager* from '$1/dept_manager.csv' with (format csv, header true);" $testDbLogin
  psql -c "\copy *salaries* from '$1/salaries.csv' with (format csv, header true);" $testDbLogin
  psql -c "\copy *titles* from '$1/titles.csv' with (format csv, header true);" $testDbLogin
}
...
```
- update parameters 
```bash
#!/usr/bin/env bash

./testQueries.sh \
  schema.sql \  # table creation logic
  queries.sql \ # table query logic
  data \        # target data location
  &> output.txt 
```
- call `run.sh` 
```bash
$ ./run.sh
```

- check `output.txt` when finished
```txt
db refresh...
---------------------------------------------
DROP DATABASE
CREATE DATABASE
---------------------------------------------
creating tables...
---------------------------------------------
CREATE TABLE
CREATE TABLE
CREATE TABLE
CREATE TABLE
CREATE TABLE
CREATE TABLE
ALTER TABLE
ALTER TABLE
ALTER TABLE
ALTER TABLE
ALTER TABLE
ALTER TABLE
---------------------------------------------
```

[0]: https://chartio.com/resources/tutorials/how-to-set-the-default-user-password-in-postgresql/
[1]: https://www.postgresql.org/docs/current/server-start.html
[2]: https://www.postgresql.org/download/
