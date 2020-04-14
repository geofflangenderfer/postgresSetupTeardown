#!/usr/bin/env bash

postgresDbLogin='postgresql://postgres:postgres@localhost:5432/postgres'
testDbLogin='postgresql://postgres:postgres@localhost:5432/test'
pathToData="/home/geoff/work/UT/homeworkGrades/09-sql/bashScripts/data" # update

main() {
  echo "db refresh..."
  echo "---------------------------------------------"
  refreshDb
  echo "---------------------------------------------"
  echo "creating tables..."
  echo "---------------------------------------------"
  loadFile DB_Creation.sql # must update for each student
  echo "---------------------------------------------"
  queryTableNames 
  echo "loading data..."
  echo "---------------------------------------------"
  loadData # must update for different table names
  echo "---------------------------------------------"
  echo "querying tables..."
  echo "---------------------------------------------"
  loadFile DB_Query.sql # must update for each student
  echo "---------------------------------------------"
  echo "db refresh..."
  echo "---------------------------------------------"
  #refreshDb
}
refreshDb() {
  psql -c "drop database test;" $postgresDbLogin
  psql -c "create database test;" $postgresDbLogin
}
getColumnInfo() {
  psql -c "\d+ $1" $postgresDbLogin
}
loadFile() {
  psql -f $1 $testDbLogin
}
loadData() {
  psql -c "\copy departments from '$pathToData/departments.csv' with (format csv, header true);" $testDbLogin
  psql -c "\copy employees from '$pathToData/employees.csv' with (format csv, header true);" $testDbLogin
  psql -c "\copy dept_emp from '$pathToData/dept_emp.csv' with (format csv, header true);" $testDbLogin
  psql -c "\copy dept_manager from '$pathToData/dept_manager.csv' with (format csv, header true);" $testDbLogin
  psql -c "\copy salaries from '$pathToData/salaries.csv' with (format csv, header true);" $testDbLogin
  psql -c "\copy titles from '$pathToData/titles.csv' with (format csv, header true);" $testDbLogin
}
queryTableNames() {
  psql -c "\dt" $testDbLogin
}
main 
