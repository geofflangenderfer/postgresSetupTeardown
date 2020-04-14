#!/usr/bin/env bash

./testQueries.sh \
  schema.sql \  # table creation logic
  queries.sql \ # table query logic
  data \        # target data location
  &> output.txt 

