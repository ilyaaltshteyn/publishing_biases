import psycopg2
from psycopg2 import OperationalError, InternalError
import shlex
from datetime import datetime
import logging

# Logging
logging.basicConfig(filename='insert_citations2.log', level=logging.INFO)
logging.info('Starting a run at time={}'.format(
    datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    )
)

# Postgres
conn = psycopg2.connect("dbname='patents' host='localhost'")
cur = conn.cursor()

def prep_val(v):
    return v.replace(',', '').replace("'", '')

Q_base = """ INSERT INTO wiki_citations (url, value_type, value) VALUES ('{url}', '{value_type}', '{value}'); """

finished = 0
with open("/Users/ilya/code/publishing_biases/prep_data/parse_dbpedia_citations/wikidataend2.ttl") as infile:
    for line in infile:
        finished += 1
        if finished % 25000 == 0:
            logging.info('Finished {} records at {}'.format(
                    finished, datetime.now().strftime("%Y-%m-%d %H:%M:%S")
                ))
        if finished == 1:
            continue
        try:
            splitup = shlex.split(line)
            value_type = prep_val(splitup[1].split('/')[-1][:-1])
            value = prep_val(splitup[2])
            url = prep_val(splitup[0][1:-1])
            Q = Q_base.format(
                url=url, value_type=value_type, value=value
            )
            cur.execute(Q)
            conn.commit()
        except (OperationalError, InternalError):
            conn = psycopg2.connect("dbname='patents' host='localhost'")
            cur = conn.cursor()
        except Exception, e:
            logging.exception(e)
