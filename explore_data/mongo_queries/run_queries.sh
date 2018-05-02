#!/bin/bash
set -euo pipefail
logfile="/home/ubuntu/publishing_biases/explore_data/mongo_queries/run_queries.log"

function set_params() {
  params="var set_xth_auth = $1, set_num_auths = $2, set_gender = '$3', set_pubtype = '$4', set_auth_count_comparison = '$5'"
  echo "Running query with these params: $params" >> $logfile
  cat mapreduce_to_yearmonth.js | sed -e "1s/.*/$params/" | mongo >> $logfile 2>&1&
}

function wait() {
  # Count running queries; if > 1 then sleep, else continue
  COUNT=$(mongo < countCurrentOp.js --quiet | tail -1) # last line is # of running queries
  while [ $COUNT -ge 2 ]
  do
      echo "Sleeping 15m while waiting for $COUNT queries to finish."
      sleep 15m
      COUNT=$(mongo < countCurrentOp.js --quiet | tail -1)
  done
}

### Pass 4 queries at a time to mongo

## Journal articles

# First auth, == 3 auths, female author, journal-articles
set_params 0 3 "female" "journal-article" "e"

# Second auth, == 3 auths, female author, journal-articles
set_params 1 3 "female" "journal-article"  "e"

# First auth, == 3 auths, male author, journal-articles
set_params 0 3 "male" "journal-article"  "e"

# Second auth, == 3 auths, male author, journal-articles
set_params 1 3 "male" "journal-article"  "e"

wait()

# First auth, == 4 auths, female author, journal-articles
set_params 0 4 "female" "journal-article"  "e"

# Second auth, == 4 auths, female author, journal-articles
set_params 1 4 "female" "journal-article"  "e"

# Third auth, == 4 auths, female author, journal-articles
set_params 2 4 "female" "journal-article"  "e"

# First auth, == 4 auths, male author, journal-articles
set_params 0 4 "male" "journal-article"  "e"

wait()

# Second auth, == 4 auths, male author, journal-articles
set_params 1 4 "male" "journal-article"  "e"

# Third auth, == 4 auths, male author, journal-articles
set_params 2 4 "male" "journal-article"  "e"

# First auth, >= 5 auths, female author, journal-articles
set_params 0 5 "female" "journal-article"  "ge"

# Second auth, >= 5 auths, female author, journal-articles
set_params 1 5 "female" "journal-article"  "ge"

wait()

# Third auth, >= 5 auths, female author, journal-articles
set_params 2 5 "female" "journal-article"  "ge"

# Fourth auth, >= 5 auths, female author, journal-articles
set_params 3 5 "female" "journal-article"  "ge"

# First auth, >= 5 auths, male author, journal-articles
set_params 0 5 "male" "journal-article"  "ge"

# Second auth, >= 5 auths, male author, journal-articles
set_params 1 5 "male" "journal-article"  "ge"

wait()

# Third auth, >= 5 auths, male author, journal-articles
set_params 2 5 "male" "journal-article"  "ge"

# Fourth auth, >= 5 auths, male author, journal-articles
set_params 3 5 "male" "journal-article"  "ge"

## Book chapters

# First auth, == 3 auths, female author, book-chapter
set_params 0 3 "female" "book-chapter" "e"

# Second auth, == 3 auths, female author, book-chapter
set_params 1 3 "female" "book-chapter"  "e"

wait()

# First auth, == 3 auths, male author, book-chapter
set_params 0 3 "male" "book-chapter"  "e"

# Second auth, == 3 auths, male author, book-chapter
set_params 1 3 "male" "book-chapter"  "e"

# First auth, >= 4 auths, female author, book-chapter
set_params 0 4 "female" "book-chapter" "ge"

# Second auth, >= 4 auths, female author, book-chapter
set_params 1 4 "female" "book-chapter"  "ge"

wait()

# Third auth, >= 4 auths, female author, book-chapter
set_params 2 4 "female" "book-chapter"  "ge"

# First auth, >= 4 auths, male author, book-chapter
set_params 0 4 "male" "book-chapter"  "ge"

# Second auth, >= 4 auths, male author, book-chapter
set_params 1 4 "male" "book-chapter"  "ge"

# Third auth, >= 4 auths, male author, book-chapter
set_params 2 4 "male" "book-chapter"  "ge"
