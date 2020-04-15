#!/usr/bin/env bash

./getQueryOutput.sh \
  sql/schema.sql `# table creation logic` \
  sql/queries.sql `# table query logic` \
  data/ `# target data location` \
  &> queryOutput.txt 

