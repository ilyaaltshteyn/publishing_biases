logfile="/home/ubuntu/publishing_biases/explore_data/mongo_queries/run_queries.log"

function set_opts() {
  opts="var set_xth_auth = $xth_auth, set_min_auths = $min_auths, set_gender = '$gend';"
  sed -i "1s/.*/$opts/" mapreduce_to_yearmonth.js
  echo "Running $opts" >> $logfile
  mongo < mapreduce_to_yearmonth.js >> $logfile 2>&1&
}

# ---

xth_auth=0
min_auths=3
gend="unknown-estimation_failure"
set_opts

xth_auth=1
min_auths=3
gend="unknown-estimation_failure"
set_opts

xth_auth=0
min_auths=4
gend="unknown-estimation_failure"
set_opts

xth_auth=1
min_auths=4
gend="unknown-estimation_failure"
set_opts

xth_auth=2
min_auths=4
gend="unknown-estimation_failure"
set_opts

# ---

xth_auth=0
min_auths=3
gend="unknown-code_failure"
set_opts

xth_auth=1
min_auths=3
gend="unknown-code_failure"
set_opts

xth_auth=0
min_auths=4
gend="unknown-code_failure"
set_opts

xth_auth=1
min_auths=4
gend="unknown-code_failure"
set_opts

xth_auth=2
min_auths=4
gend="unknown-code_failure"
set_opts
