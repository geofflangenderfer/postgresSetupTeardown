#!/usr/bin/env bash

./testQueries.sh \
  sql/schema.sql `# table creation logic` \
  sql/queries.sql `# table query logic` \
  data/ `# target data location` \
  &> output.txt 

