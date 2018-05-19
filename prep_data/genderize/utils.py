import logging
import re


def get_gender(detector_instance, author):
    """ detector_instance is an instance of gender-guesser's gender.Detector().
        author is an author first name string. author is a dict with author name
        string and failure status, returned by get_{postgres/mongo}_author().

        If there's an author, the function will estimate the gender of the name.
        It will return one of several possible result codes:
            - unknown-data_failure
            - unknown-no_first_name
            - unknown-single_character_name
            - unknown-initials_only
            - unknown-estimation_failure
            - any result possible from the detector_instance, except unknown.
    """
    assert 'failed' in author and 'name' in author

    if author['failed']:
        return 'unknown-data_failure'

    name = author['name']
    try:
        if len(name) == 0:
            return 'unknown-no_first_name'

        if len(name) == 1:
            return 'unknown-single_character_name'

        name_sans_initials = re.sub(r'([\w\W]{1}[.]{1})', '', name)
        if not len(name_sans_initials):
            return 'unknown-initials_only'

        gender_estimate = detector_instance.get_gender(name)
        if gender_estimate == 'unknown':
            return 'unknown-estimation_failure'

        return gender_estimate

    except Exception, e:
        logging.info('Was working on author string: ', str(name))
        logging.exception(e)
        return 'unknown-code_failure'


def get_mongo_author(record):
    """ Record is a record in the mongo collection dat.crossref. It may have a
        key with author's given name-- `given`. This function just extracts that
        first name and returns it, along with a failure status. If failed,
        failure status is True, otherwise is False. If there's no first name,
        returns an empty string. """
    if not isinstance(record, dict):
        return {'name': None, 'failed': True}

    try:
        if 'given' not in record or len(record['given']) == 0:
            return {'name': '', 'failed': False}

        return {
            'name': record['given'].split(' ')[0],  # Take only first word
            'failed': False
        }
    except:
        return {'name': '', 'failed': True}


def get_postgres_author(record):
    """ Record is a row from the postgres table rawinventor. It should have the
        author's given name in a column called 'name_first'. This function just
        returns that name if it's not null, with a failure status. If failed,
        failure status is True, otherwise is False. If there's no first name,
        returns an empty string. """
    assert len(record) == 9

    try:
        name = record[4]  # name_first is the 5th column
        if not name or len(name) == 0:
            return {'name': '', 'failed': False}

        return {
            'name': name.split(' ')[0],  # Take only first word
            'failed': False
        }
    except:
        return {'name': '', 'failed': True}


def set_mongo_gender(collection, record_id, genders):
    """ Sets `author-genders` key for the record_id in mongo's dat.crossref.
    """
    collection.update(
        {"_id": record_id},
        {"$set": {"author-genders": genders}}
    )


def set_postgres_gender(cursor, uuid, gender):
    """ Sets `author_gender` column for the row with given uuid. """
    q = "UPDATE rawinventor SET author_gender='{g}' WHERE uuid='{id}';"
    cursor.execute(q.format(g=gender, id=uuid))


def get_mongo_cursor(collection):
    """ Gets cursor pointing at records without the field 'author-genders'.
        Returns True and the cursor if cursor has at least 1 records. Otherwise
        returns False and None.
        Much faster than using .count() on a large cursor.
    """
    c = collection.find({
        'author-genders': {'$exists': False},
        'author': {'$exists': True}
        })

    for record in c:
        c.rewind()
        # If you're in this loop there's something in the cursor
        return {'empty': False, 'cursor': c}
    return {'empty': True, 'cursor': c}

get_postgres_uuid = lambda record: record[0]
