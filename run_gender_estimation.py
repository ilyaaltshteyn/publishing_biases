from pymongo import MongoClient
import gender_guesser.detector as gender
from datetime import datetime
import logging
from utils import get_gender, get_cursor, set_gender

## Logging
logging.basicConfig(filename='gender_estimation.log',level=logging.INFO)
logging.info('Starting a run at time={}'.format(
    datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    )
)

## Mongo
client = MongoClient('mongodb://localhost:27017')
db=client.dat
collection = db.crossref

## Gender estimation
detector = gender.Detector(case_sensitive=False)


# Get cursor, loop through it, estimate genders + write estimates to mongo
results_exist = True
finished = 0

while results_exist:
    try:
        cursor = get_cursor(collection)
        if not cursor['empty']:
            for publication in cursor['cursor']:
                genders = []
                for auth in publication['author']:
                    gender = get_gender(detector, auth)
                    genders.append(gender)

                set_gender(collection, publication['_id'], genders)
                finished += 1
                if finished % 100000 == 0:
                    logging.info('Finished {} records so far.'.format(finished))

        else:
            results_exist = False

    except Exception, e:
        logging.exception(e)
