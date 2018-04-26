# First auth, female, papers with >= 3 auths
nohup mongo --eval "var set_xth_auth = 0, set_min_auths = 3, set_gender = 'female';" mapreduce_to_yearmonth.js >> /home/ubuntu/publishing_biases/explore_data/mongo_queries/mapreduce.log 2>&1&
