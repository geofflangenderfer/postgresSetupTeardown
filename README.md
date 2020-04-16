## What is this?
- Here's a [video](https://youtu.be/ELCZ5dAS6Zg) on correcting your query logic.
- These scripts use `psql` and bash to automate:
  - database setup
  - creating tables
  - loading data from csv
  - querying tables
  - database teardown
```bash
$ ./run.sh && cat output/queryOutput.txt | head -20
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
---------------------------------------------
```

## Why did you do this?
calling `psql` commands by hand was taking ~1.25 hours to grade an assignment. It took ~10 hours to write this, but grading an assignment now takes ~0.33 hours

## What tech stack did you use?
- mac/linux/WSL terminal environment
- `psql`
- PostgreSQL database
- bash 

## How can I use this?

- [install postgres][2]
- [start postgres server][1]
- [set postgres user password][0] to 'password'
```bash
$ sudo -u postgres psql
postgres=# ALTER USER postgres PASSWORD 'postgres';
ALTER ROLE
```
- check that student table names coincide with `loadData`
```bash
# src/getQueryOutput.sh
...
loadData() {
  psql -c "\copy <departments> from '$1/departments.csv' with (format csv, header true);" $testDbLogin
  psql -c "\copy <employees> from '$1/employees.csv' with (format csv, header true);" $testDbLogin
  psql -c "\copy <dept_emp> from '$1/dept_emp.csv' with (format csv, header true);" $testDbLogin
  psql -c "\copy <dept_manager> from '$1/dept_manager.csv' with (format csv, header true);" $testDbLogin
  psql -c "\copy <salaries> from '$1/salaries.csv' with (format csv, header true);" $testDbLogin
  psql -c "\copy <titles> from '$1/titles.csv' with (format csv, header true);" $testDbLogin
}
...
```
- update `run.sh` parameters 
```bash
#!/usr/bin/env bash

./src/getQueryOutput.sh \
  sql/schema.sql `# table creation logic` \
  sql/queries.sql `# table query logic` \
  data/ `# target data location` \
  &> output/queryOutput.txt 
```
- call `run.sh` 
```bash
$ ./run.sh
```

- check `output/queryOutput.txt` when finished
```bash
$ cat output/queryOutput.txt
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
...
```

[0]: https://chartio.com/resources/tutorials/how-to-set-the-default-user-password-in-postgresql/
[1]: https://www.postgresql.org/docs/current/server-start.html
[2]: https://www.postgresql.org/download/
