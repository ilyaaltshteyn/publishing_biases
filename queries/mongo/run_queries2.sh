#!/bin/bash
set -euo pipefail
logfile="/home/ubuntu/publishing_biases/queries/mongo/run_queries.log"
queries_started=0

function query() {
  params="var set_xth_auth = $1, set_num_auths = $2, set_gender = '$3', set_pubtype = '$4', set_auth_count_comparison = '$5'"
  echo "Running query with these params: $params" >> $logfile
  cat mapreduce_to_year.js | sed -e "1s/.*/$params/" | mongo >> $logfile 2>&1&
  queries_started=$((queries_started+1))
  echo "Queries started so far: $queries_started" >> $logfile
}

function wait() {
  # Count running queries; if > 1 then sleep, else continue
  COUNT=$(mongo < countCurrentOp.js --quiet | tail -1) # last line is # of running queries
  while [ $COUNT -ge 2 ]
  do
      echo "Sleeping 15m while waiting for $COUNT queries to finish." >> $logfile
      sleep 15m
      COUNT=$(mongo < countCurrentOp.js --quiet | tail -1)
  done
}

### Pass 4 queries at a time to mongo

## Journal articles

# First auth, >= 3 auths, female author, books
query 0 3 "female" "book" "ge"

# Second auth, >= 3 auths, female author, books
query 1 3 "female" "book" "ge"

# First auth, >= 3 auths, male author, books
query 0 3 "male" "book" "ge"

# Second auth, >= 3 auths, male author, books
query 1 3 "male" "book" "ge"

wait

# First auth, >= 3 auths, female author, dataset
query 0 3 "female" "dataset" "ge"

# Second auth, >= 3 auths, female author, dataset
query 1 3 "female" "dataset" "ge"

# First auth, >= 3 auths, male author, dataset
query 0 3 "male" "dataset" "ge"

# Second auth, >= 3 auths, male author, dataset
query 1 3 "male" "dataset" "ge"

wait

# First auth, >= 3 auths, female author, proceedings-article
query 0 3 "female" "proceedings-article" "ge"

# Second auth, >= 3 auths, female author, proceedings-article
query 1 3 "female" "proceedings-article" "ge"

# First auth, >= 3 auths, male author, proceedings-article
query 0 3 "male" "proceedings-article" "ge"

# Second auth, >= 3 auths, male author, proceedings-article
query 1 3 "male" "proceedings-article" "ge"
