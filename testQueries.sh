#!/usr/bin/env bash

main() {
  echo "db refresh..."
  echo "---------------------------------------------"
  refreshDb
  echo "---------------------------------------------"
  echo "creating tables..."
  echo "---------------------------------------------"
  createTables TableCreation.sql # must update for each student
  echo "---------------------------------------------"
  #queryTableNames 
  echo "loading data..."
  echo "---------------------------------------------"
  loadData
  echo "---------------------------------------------"
  echo "querying tables..."
  echo "---------------------------------------------"
  queryTablesWithFile combinedAnalysis.sql # must update for each student
  echo "---------------------------------------------"
  echo "db refresh..."
  echo "---------------------------------------------"
  refreshDb
}
refreshDb() {
  psql -c "drop database test;" postgresql://postgres:postgres@localhost:5432/postgres
  psql -c "create database test;" postgresql://postgres:postgres@localhost:5432/postgres
}
createTables() {
  psql -f $1 postgresql://postgres:postgres@localhost:5432/test
}
loadData() {
  pathToData="/home/geoff/work/UT/homeworkGrades/09-sql/bashScripts/data" 

  psql -c "\copy departments from '$pathToData/departments.csv' with (format csv, header true);" postgresql://postgres:postgres@localhost:5432/test
  psql -c "\copy employees from '$pathToData/employees.csv' with (format csv, header true);" postgresql://postgres:postgres@localhost:5432/test
  psql -c "\copy dept_emp from '$pathToData/dept_emp.csv' with (format csv, header true);" postgresql://postgres:postgres@localhost:5432/test
  psql -c "\copy dept_manager from '$pathToData/dept_manager.csv' with (format csv, header true);" postgresql://postgres:postgres@localhost:5432/test
  psql -c "\copy salaries from '$pathToData/salaries.csv' with (format csv, header true);" postgresql://postgres:postgres@localhost:5432/test
  psql -c "\copy titles from '$pathToData/titles.csv' with (format csv, header true);" postgresql://postgres:postgres@localhost:5432/test
}
queryTablesWithFile() {
  psql -f $1 postgresql://postgres:postgres@localhost:5432/test
}
queryTableNames() {
  psql -c "\dt" postgresql://postgres:postgres@localhost:5432/test
}
main 
