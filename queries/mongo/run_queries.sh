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

# First auth, == 3 auths, female author, journal-articles
query 0 3 "female" "journal-article" "e"

# Second auth, == 3 auths, female author, journal-articles
query 1 3 "female" "journal-article" "e"

# First auth, == 3 auths, male author, journal-articles
query 0 3 "male" "journal-article" "e"

# Second auth, == 3 auths, male author, journal-articles
query 1 3 "male" "journal-article" "e"

wait

# First auth, == 4 auths, female author, journal-articles
query 0 4 "female" "journal-article" "e"

# Second auth, == 4 auths, female author, journal-articles
query 1 4 "female" "journal-article" "e"

# Third auth, == 4 auths, female author, journal-articles
query 2 4 "female" "journal-article" "e"

# First auth, == 4 auths, male author, journal-articles
query 0 4 "male" "journal-article" "e"

wait

# Second auth, == 4 auths, male author, journal-articles
query 1 4 "male" "journal-article" "e"

# Third auth, == 4 auths, male author, journal-articles
query 2 4 "male" "journal-article" "e"

# First auth, >= 5 auths, female author, journal-articles
query 0 5 "female" "journal-article" "ge"

# Second auth, >= 5 auths, female author, journal-articles
query 1 5 "female" "journal-article" "ge"

wait

# Third auth, >= 5 auths, female author, journal-articles
query 2 5 "female" "journal-article" "ge"

# Fourth auth, >= 5 auths, female author, journal-articles
query 3 5 "female" "journal-article" "ge"

# First auth, >= 5 auths, male author, journal-articles
query 0 5 "male" "journal-article" "ge"

# Second auth, >= 5 auths, male author, journal-articles
query 1 5 "male" "journal-article" "ge"

wait

# Third auth, >= 5 auths, male author, journal-articles
query 2 5 "male" "journal-article" "ge"

# Fourth auth, >= 5 auths, male author, journal-articles
query 3 5 "male" "journal-article" "ge"

## Book chapters

# First auth, == 3 auths, female author, book-chapter
query 0 3 "female" "book-chapter" "e"

# Second auth, == 3 auths, female author, book-chapter
query 1 3 "female" "book-chapter" "e"

wait

# First auth, == 3 auths, male author, book-chapter
query 0 3 "male" "book-chapter" "e"

# Second auth, == 3 auths, male author, book-chapter
query 1 3 "male" "book-chapter" "e"

# First auth, >= 4 auths, female author, book-chapter
query 0 4 "female" "book-chapter" "ge"

# Second auth, >= 4 auths, female author, book-chapter
query 1 4 "female" "book-chapter" "ge"

wait

# Third auth, >= 4 auths, female author, book-chapter
query 2 4 "female" "book-chapter" "ge"

# First auth, >= 4 auths, male author, book-chapter
query 0 4 "male" "book-chapter" "ge"

# Second auth, >= 4 auths, male author, book-chapter
query 1 4 "male" "book-chapter" "ge"

# Third auth, >= 4 auths, male author, book-chapter
query 2 4 "male" "book-chapter" "ge"

wait

# First auth, == 3 auths, mostly_female author, journal-articles
query 0 3 "mostly_female" "journal-article" "e"

# Second auth, == 3 auths, mostly_female author, journal-articles
query 1 3 "mostly_female" "journal-article" "e"

# First auth, == 3 auths, mostly_male author, journal-articles
query 0 3 "mostly_male" "journal-article" "e"

# Second auth, == 3 auths, mostly_male author, journal-articles
query 1 3 "mostly_male" "journal-article" "e"

wait

# First auth, == 4 auths, mostly_female author, journal-articles
query 0 4 "mostly_female" "journal-article" "e"

# Second auth, == 4 auths, mostly_female author, journal-articles
query 1 4 "mostly_female" "journal-article" "e"

# Third auth, == 4 auths, mostly_female author, journal-articles
query 2 4 "mostly_female" "journal-article" "e"

# First auth, == 4 auths, mostly_male author, journal-articles
query 0 4 "mostly_male" "journal-article" "e"

wait

# Second auth, == 4 auths, mostly_male author, journal-articles
query 1 4 "mostly_male" "journal-article" "e"

# Third auth, == 4 auths, mostly_male author, journal-articles
query 2 4 "mostly_male" "journal-article" "e"

# First auth, >= 5 auths, mostly_female author, journal-articles
query 0 5 "mostly_female" "journal-article" "ge"

# Second auth, >= 5 auths, mostly_female author, journal-articles
query 1 5 "mostly_female" "journal-article" "ge"

wait

# Third auth, >= 5 auths, mostly_female author, journal-articles
query 2 5 "mostly_female" "journal-article" "ge"

# Fourth auth, >= 5 auths, mostly_female author, journal-articles
query 3 5 "mostly_female" "journal-article" "ge"

# First auth, >= 5 auths, mostly_male author, journal-articles
query 0 5 "mostly_male" "journal-article" "ge"

# Second auth, >= 5 auths, mostly_male author, journal-articles
query 1 5 "mostly_male" "journal-article" "ge"

wait

# Third auth, >= 5 auths, mostly_male author, journal-articles
query 2 5 "mostly_male" "journal-article" "ge"

# Fourth auth, >= 5 auths, mostly_male author, journal-articles
query 3 5 "mostly_male" "journal-article" "ge"

## Book chapters

# First auth, == 3 auths, mostly_female author, book-chapter
query 0 3 "mostly_female" "book-chapter" "e"

# Second auth, == 3 auths, mostly_female author, book-chapter
query 1 3 "mostly_female" "book-chapter" "e"

wait

# First auth, == 3 auths, mostly_male author, book-chapter
query 0 3 "mostly_male" "book-chapter" "e"

# Second auth, == 3 auths, mostly_male author, book-chapter
query 1 3 "mostly_male" "book-chapter" "e"

# First auth, >= 4 auths, mostly_female author, book-chapter
query 0 4 "mostly_female" "book-chapter" "ge"

# Second auth, >= 4 auths, mostly_female author, book-chapter
query 1 4 "mostly_female" "book-chapter" "ge"

wait

# Third auth, >= 4 auths, mostly_female author, book-chapter
query 2 4 "mostly_female" "book-chapter" "ge"

# First auth, >= 4 auths, mostly_male author, book-chapter
query 0 4 "mostly_male" "book-chapter" "ge"

# Second auth, >= 4 auths, mostly_male author, book-chapter
query 1 4 "mostly_male" "book-chapter" "ge"

# Third auth, >= 4 auths, mostly_male author, book-chapter
query 2 4 "mostly_male" "book-chapter" "ge"

wait

# First auth, == 3 auths, unknown-estimation_failure, journal-articles
query 0 3 "unknown-estimation_failure" "journal-article" "e"

# Second auth, == 3 auths, unknown-estimation_failure, journal-articles
query 1 3 "unknown-estimation_failure" "journal-article" "e"

# First auth, == 3 auths, unknown-code_failure, journal-articles
query 0 3 "unknown-code_failure" "journal-article" "e"

# Second auth, == 3 auths, unknown-code_failure, journal-articles
query 1 3 "unknown-code_failure" "journal-article" "e"

wait

# First auth, == 4 auths, unknown-estimation_failure, journal-articles
query 0 4 "unknown-estimation_failure" "journal-article" "e"

# Second auth, == 4 auths, unknown-estimation_failure, journal-articles
query 1 4 "unknown-estimation_failure" "journal-article" "e"

# Third auth, == 4 auths, unknown-estimation_failure, journal-articles
query 2 4 "unknown-estimation_failure" "journal-article" "e"

# First auth, == 4 auths, unknown-code_failure, journal-articles
query 0 4 "unknown-code_failure" "journal-article" "e"

wait

# Second auth, == 4 auths, unknown-code_failure, journal-articles
query 1 4 "unknown-code_failure" "journal-article" "e"

# Third auth, == 4 auths, unknown-code_failure, journal-articles
query 2 4 "unknown-code_failure" "journal-article" "e"

# First auth, >= 5 auths, unknown-estimation_failure, journal-articles
query 0 5 "unknown-estimation_failure" "journal-article" "ge"

# Second auth, >= 5 auths, unknown-estimation_failure, journal-articles
query 1 5 "unknown-estimation_failure" "journal-article" "ge"

wait

# Third auth, >= 5 auths, unknown-estimation_failure, journal-articles
query 2 5 "unknown-estimation_failure" "journal-article" "ge"

# Fourth auth, >= 5 auths, unknown-estimation_failure, journal-articles
query 3 5 "unknown-estimation_failure" "journal-article" "ge"

# First auth, >= 5 auths, unknown-code_failure, journal-articles
query 0 5 "unknown-code_failure" "journal-article" "ge"

# Second auth, >= 5 auths, unknown-code_failure, journal-articles
query 1 5 "unknown-code_failure" "journal-article" "ge"

wait

# Third auth, >= 5 auths, unknown-code_failure, journal-articles
query 2 5 "unknown-code_failure" "journal-article" "ge"

# Fourth auth, >= 5 auths, unknown-code_failure, journal-articles
query 3 5 "unknown-code_failure" "journal-article" "ge"

## Book chapters

# First auth, == 3 auths, unknown-estimation_failure, book-chapter
query 0 3 "unknown-estimation_failure" "book-chapter" "e"

# Second auth, == 3 auths, unknown-estimation_failure, book-chapter
query 1 3 "unknown-estimation_failure" "book-chapter" "e"

wait

# First auth, == 3 auths, unknown-code_failure, book-chapter
query 0 3 "unknown-code_failure" "book-chapter" "e"

# Second auth, == 3 auths, unknown-code_failure, book-chapter
query 1 3 "unknown-code_failure" "book-chapter" "e"

# First auth, >= 4 auths, unknown-estimation_failure, book-chapter
query 0 4 "unknown-estimation_failure" "book-chapter" "ge"

# Second auth, >= 4 auths, unknown-estimation_failure, book-chapter
query 1 4 "unknown-estimation_failure" "book-chapter" "ge"

wait

# Third auth, >= 4 auths, unknown-estimation_failure, book-chapter
query 2 4 "unknown-estimation_failure" "book-chapter" "ge"

# First auth, >= 4 auths, unknown-code_failure, book-chapter
query 0 4 "unknown-code_failure" "book-chapter" "ge"

# Second auth, >= 4 auths, unknown-code_failure, book-chapter
query 1 4 "unknown-code_failure" "book-chapter" "ge"

# Third auth, >= 4 auths, unknown-code_failure, book-chapter
query 2 4 "unknown-code_failure" "book-chapter" "ge"

wait

# First auth, == 3 auths, unknown-single_character_name, journal-articles
query 0 3 "unknown-single_character_name" "journal-article" "e"

# Second auth, == 3 auths, unknown-single_character_name, journal-articles
query 1 3 "unknown-single_character_name" "journal-article" "e"

# First auth, == 3 auths, unknown-initials_only, journal-articles
query 0 3 "unknown-initials_only" "journal-article" "e"

# Second auth, == 3 auths, unknown-initials_only, journal-articles
query 1 3 "unknown-initials_only" "journal-article" "e"

wait

# First auth, == 4 auths, unknown-single_character_name, journal-articles
query 0 4 "unknown-single_character_name" "journal-article" "e"

# Second auth, == 4 auths, unknown-single_character_name, journal-articles
query 1 4 "unknown-single_character_name" "journal-article" "e"

# Third auth, == 4 auths, unknown-single_character_name, journal-articles
query 2 4 "unknown-single_character_name" "journal-article" "e"

# First auth, == 4 auths, unknown-initials_only, journal-articles
query 0 4 "unknown-initials_only" "journal-article" "e"

wait

# Second auth, == 4 auths, unknown-initials_only, journal-articles
query 1 4 "unknown-initials_only" "journal-article" "e"

# Third auth, == 4 auths, unknown-initials_only, journal-articles
query 2 4 "unknown-initials_only" "journal-article" "e"

# First auth, >= 5 auths, unknown-single_character_name, journal-articles
query 0 5 "unknown-single_character_name" "journal-article" "ge"

# Second auth, >= 5 auths, unknown-single_character_name, journal-articles
query 1 5 "unknown-single_character_name" "journal-article" "ge"

wait

# Third auth, >= 5 auths, unknown-single_character_name, journal-articles
query 2 5 "unknown-single_character_name" "journal-article" "ge"

# Fourth auth, >= 5 auths, unknown-single_character_name, journal-articles
query 3 5 "unknown-single_character_name" "journal-article" "ge"

# First auth, >= 5 auths, unknown-initials_only, journal-articles
query 0 5 "unknown-initials_only" "journal-article" "ge"

# Second auth, >= 5 auths, unknown-initials_only, journal-articles
query 1 5 "unknown-initials_only" "journal-article" "ge"

wait

# Third auth, >= 5 auths, unknown-initials_only, journal-articles
query 2 5 "unknown-initials_only" "journal-article" "ge"

# Fourth auth, >= 5 auths, unknown-initials_only, journal-articles
query 3 5 "unknown-initials_only" "journal-article" "ge"

## Book chapters

# First auth, == 3 auths, unknown-single_character_name, book-chapter
query 0 3 "unknown-single_character_name" "book-chapter" "e"

# Second auth, == 3 auths, unknown-single_character_name, book-chapter
query 1 3 "unknown-single_character_name" "book-chapter" "e"

wait

# First auth, == 3 auths, unknown-initials_only, book-chapter
query 0 3 "unknown-initials_only" "book-chapter" "e"

# Second auth, == 3 auths, unknown-initials_only, book-chapter
query 1 3 "unknown-initials_only" "book-chapter" "e"

# First auth, >= 4 auths, unknown-single_character_name, book-chapter
query 0 4 "unknown-single_character_name" "book-chapter" "ge"

# Second auth, >= 4 auths, unknown-single_character_name, book-chapter
query 1 4 "unknown-single_character_name" "book-chapter" "ge"

wait

# Third auth, >= 4 auths, unknown-single_character_name, book-chapter
query 2 4 "unknown-single_character_name" "book-chapter" "ge"

# First auth, >= 4 auths, unknown-initials_only, book-chapter
query 0 4 "unknown-initials_only" "book-chapter" "ge"

# Second auth, >= 4 auths, unknown-initials_only, book-chapter
query 1 4 "unknown-initials_only" "book-chapter" "ge"

# Third auth, >= 4 auths, unknown-initials_only, book-chapter
query 2 4 "unknown-initials_only" "book-chapter" "ge"

wait

# First auth, == 3 auths, andy, journal-articles
query 0 3 "andy" "journal-article" "e"

# Second auth, == 3 auths, andy, journal-articles
query 1 3 "andy" "journal-article" "e"

# First auth, == 4 auths, andy, journal-articles
query 0 4 "andy" "journal-article" "e"

# Second auth, == 4 auths, andy, journal-articles
query 1 4 "andy" "journal-article" "e"

wait

# Third auth, == 4 auths, andy, journal-articles
query 2 4 "andy" "journal-article" "e"

# First auth, >= 5 auths, andy, journal-articles
query 0 5 "andy" "journal-article" "ge"

# Second auth, >= 5 auths, andy, journal-articles
query 1 5 "andy" "journal-article" "ge"

# Third auth, >= 5 auths, andy, journal-articles
query 2 5 "andy" "journal-article" "ge"

wait

# Fourth auth, >= 5 auths, andy, journal-articles
query 3 5 "andy" "journal-article" "ge"

# First auth, == 3 auths, andy, book-chapter
query 0 3 "andy" "book-chapter" "e"

# Second auth, == 3 auths, andy, book-chapter
query 1 3 "andy" "book-chapter" "e"

# First auth, >= 4 auths, andy, book-chapter
query 0 4 "andy" "book-chapter" "ge"

wait

# Second auth, >= 4 auths, andy, book-chapter
query 1 4 "andy" "book-chapter" "ge"

# Third auth, >= 4 auths, andy, book-chapter
query 2 4 "andy" "book-chapter" "ge"
