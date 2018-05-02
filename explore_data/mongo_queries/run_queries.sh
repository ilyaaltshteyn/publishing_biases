#!/bin/bash
set -euo pipefail
logfile="/home/ubuntu/publishing_biases/explore_data/mongo_queries/run_queries.log"

function set_opts() {
  opts="var set_xth_auth = $1, set_num_auths = $2, set_gender = '$3', set_pubtype = '$4', set_auth_count_comparison = '$5'"
  echo "Running $opts" >> $logfile
  cat mapreduce_to_yearmonth.js | sed -e "1s/.*/$opts/" | mongo >> $logfile 2>&1&
}

function wait() {
  # Count running queries; if > 1 then sleep, else continue
  COUNT=$(mongo < countCurrentOp.js --quiet | tail -1)
  while [ $COUNT -ge 2 ]
  do
      echo "Sleeping 15m while waiting for $COUNT queries to finish."
      sleep 15m
      COUNT=$(mongo < countCurrentOp.js --quiet | tail -1)
  done
}

## Pass 4 queries at a time to mongo

# First auth, papers with == 3 auths, female author, journal-articles
set_opts 0 3 "female" "journal-article" "e"

# Second auth, papers with == 3 auths, female author, journal-articles
set_opts 1 3 "female" "journal-article"  "e"

# First auth, papers with == 3 auths, male author, journal-articles
set_opts 0 3 "male" "journal-article"  "e"

# Second auth, papers with == 3 auths, male author, journal-articles
set_opts 1 3 "male" "journal-article"  "e"

wait()

# First auth, papers with == 4 auths, female author, journal-articles
set_opts 0 4 "female" "journal-article"  "e"

# Second auth, papers with == 4 auths, female author, journal-articles
set_opts 1 4 "female" "journal-article"  "e"

# Third auth, papers with == 4 auths, female author, journal-articles
set_opts 2 4 "female" "journal-article"  "e"

# First auth, papers with == 4 auths, male author, journal-articles
set_opts 0 4 "male" "journal-article"  "e"

wait()

# Second auth, papers with == 4 auths, male author, journal-articles
set_opts 1 4 "male" "journal-article"  "e"

# Third auth, papers with == 4 auths, male author, journal-articles
set_opts 2 4 "male" "journal-article"  "e"

# First auth, papers with >= 5 auths, female author, journal-articles
set_opts 0 5 "female" "journal-article"  "ge"

# Second auth, papers with >= 5 auths, female author, journal-articles
set_opts 1 5 "female" "journal-article"  "ge"

wait()

# Third auth, papers with >= 5 auths, female author, journal-articles
set_opts 2 5 "female" "journal-article"  "ge"

# Fourth auth, papers with >= 5 auths, female author, journal-articles
set_opts 3 5 "female" "journal-article"  "ge"

# First auth, papers with >= 5 auths, male author, journal-articles
set_opts 0 5 "male" "journal-article"  "ge"

# Second auth, papers with >= 5 auths, male author, journal-articles
set_opts 1 5 "male" "journal-article"  "ge"

wait()

# Third auth, papers with >= 5 auths, male author, journal-articles
set_opts 2 5 "male" "journal-article"  "ge"

# Fourth auth, papers with >= 5 auths, male author, journal-articles
set_opts 3 5 "male" "journal-article"  "ge"
