import psycopg2
import gender_guesser.detector as gender
from datetime import datetime
import logging
from utils import get_gender, get_postgres_author, set_postgres_gender, get_postgres_uuid

# Logging
logging.basicConfig(filename='gender_estimation.log', level=logging.INFO)
logging.info('Starting a run at time={}'.format(
    datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    )
)

# Postgres
conn = psycopg2.connect("dbname='patents' host='localhost'")

# Gender estimation
detector = gender.Detector(case_sensitive=False)

# Get cursors for read/write, loop through read + use write to update records
read_q = "SELECT * FROM rawinventor WHERE author_gender IS NULL LIMIT 1000;"
read_cur = conn.cursor()
write_cur = conn.cursor()
working = True
finished = 0

while working:
    # Get the next 1k records
    read_cur.execute(read_q)
    results = read_cur.fetchall()
    if read_cur.rowcount == 0:
        working = False

    try:
        for row in results:
            # Get info for estimating + setting gender
            auth = get_postgres_author(row)
            gend = get_gender(detector, auth)
            uuid = get_postgres_uuid(row)

            # Set gender
            set_postgres_gender(write_cur, uuid, gend)
            conn.commit()

            # Track progress
            finished += 1
            if finished % 10000 == 0:
                logging.info('Finished {} records at {}'.format(
                    finished, datetime.now().strftime("%Y-%m-%d %H:%M:%S")
                ))

    except Exception, e:
        logging.exception(e)

logging.info('Done at {}'.format(
    datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    )
)
