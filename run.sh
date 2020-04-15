#!/usr/bin/env bash

./src/getQueryOutput.sh \
  sql/schema.sql `# table creation logic` \
  sql/queries.sql `# table query logic` \
  data/ `# target data location` \
  &> output/queryOutput.txt 

