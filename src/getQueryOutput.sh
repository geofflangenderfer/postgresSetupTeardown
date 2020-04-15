#!/usr/bin/env bash

postgresDbLogin='postgresql://postgres:postgres@localhost:5432/postgres'
testDbLogin='postgresql://postgres:postgres@localhost:5432/test'

main() {
  echo "db refresh..."
  echo "---------------------------------------------"
  refreshDb
  echo "---------------------------------------------"
  echo "creating tables..."
  echo "---------------------------------------------"
  loadFile $1 
  echo "---------------------------------------------"
  echo "table names.."
  echo "---------------------------------------------"
  queryTableNames 
  echo "---------------------------------------------"
  echo "loading data..."
  echo "---------------------------------------------"
  loadData $3 
  echo "---------------------------------------------"
  echo "querying tables..."
  echo "---------------------------------------------"
  loadFile $2 
  echo "---------------------------------------------"
  echo "db refresh..."
  echo "---------------------------------------------"
  refreshDb
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
  psql -c "\copy departments from '$1/departments.csv' with (format csv, header true);" $testDbLogin
  psql -c "\copy employees from '$1/employees.csv' with (format csv, header true);" $testDbLogin
  psql -c "\copy dept_emp from '$1/dept_emp.csv' with (format csv, header true);" $testDbLogin
  psql -c "\copy dept_manager from '$1/dept_manager.csv' with (format csv, header true);" $testDbLogin
  psql -c "\copy salaries from '$1/salaries.csv' with (format csv, header true);" $testDbLogin
  psql -c "\copy titles from '$1/titles.csv' with (format csv, header true);" $testDbLogin
}
queryTableNames() {
  psql -c "\dt" $testDbLogin
}
#echo "1 is $1 2 is $2 3 is $3"
main $1 $2 $3
