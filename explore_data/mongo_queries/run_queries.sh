logfile = "/home/ubuntu/publishing_biases/explore_data/mongo_queries/run_queries.log"

function set_opts() {
  opts="var set_xth_auth = $xth_auth, set_min_auths = $min_auths, set_gender = '$gend';"
  sed -i "1s/.*/$opts/" mapreduce_to_yearmonth.js
  echo "Running $opts" >> $logfile
  mongo < mapreduce_to_yearmonth.js >> $logfile 2>&1&
}

## --- FIRST DO FEMALE NAMES ---
# First auth, papers with >= 3 auths, female author
xth_auth=0
min_auths=3
gend="female"
set_opts

# Second auth, papers with >= 3 auths, female author
xth_auth=1
min_auths=3
gend="female"
set_opts

# First auth, papers with >= 4 auths, female author
xth_auth=0
min_auths=4
gend="female"
set_opts

# Second auth, papers with >= 4 auths, female author
xth_auth=1
min_auths=4
gend="female"
set_opts

# Third auth, papers with >= 4 auths, female author
xth_auth=2
min_auths=4
gend="female"
set_opts

## --- SAME THING FOR MALE NAMES ---

# First auth, papers with >= 3 auths, female author
xth_auth=0
min_auths=3
gend="male"
set_opts

# Second auth, papers with >= 3 auths, female author
xth_auth=1
min_auths=3
gend="male"
set_opts

# First auth, papers with >= 4 auths, female author
xth_auth=0
min_auths=4
gend="male"
set_opts

# Second auth, papers with >= 4 auths, female author
xth_auth=1
min_auths=4
gend="male"
set_opts

# Third auth, papers with >= 4 auths, female author
xth_auth=2
min_auths=4
gend="male"
set_opts
