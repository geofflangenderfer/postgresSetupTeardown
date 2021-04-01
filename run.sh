#!/usr/bin/env bash

# start postgres server
sudo systemctl start postgresql@12-main
./src/getQueryOutput.sh                               \
  sql/schema.sql            ` # table creation logic` \
  sql/queries.sql           ` # table query logic`    \
  data/                     ` # target data location` \
  &> output/queryOutput.txt 
